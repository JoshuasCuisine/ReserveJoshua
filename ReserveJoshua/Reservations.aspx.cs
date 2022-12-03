using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Net;
using System.Text;
using System.Data.SqlTypes;
using System.Collections;
using Newtonsoft.Json.Linq;

namespace ReserveJoshua
{
    public partial class Reservations : System.Web.UI.Page
    {
        SqlConnection Con = new SqlConnection("Server=tcp:joshuascuisine.database.windows.net,1433;Initial Catalog=JoshuasCuisine;Persist Security Info=False;User ID=derni;Password=$84u3r!duff!w1ck01dt$;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                autoFillFields();
            }
        }

        protected void autoFillFields()
        {
            //Check if registered
            if (!isRegistered())
            {
                return;
            }

            //If so, populate cells
            if (Con.State == ConnectionState.Closed)
            {
                Con.Open();
            }
            string name = Session["UserName"].ToString();
            SqlCommand command = new SqlCommand("GetUserDetails", Con);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@Name", name);
            SqlDataReader reader = command.ExecuteReader();
            if (reader.Read())
            {
                txtName.Text = reader.GetString(1);
                txtPhone.Text = reader.GetString(2);
                txtEmail.Text = reader.GetString(3);
            }
            Con.Close();
        }

        protected class highTrafficDates
        {
            public int ID { get; set; }
            public DateTime date { get; set; }
        }

        protected bool isHighTraffic()
        {
            DateTime ParsedDate;
            if (DateTime.TryParse(txtDate.Text, out ParsedDate))
            {
                //High-traffic if weekend
                if (ParsedDate.DayOfWeek == DayOfWeek.Sunday || ParsedDate.DayOfWeek == DayOfWeek.Saturday)
                    return true;
                //High-traffic if it's in the array of high-traffic days
                if (Con.State == ConnectionState.Closed)
                {
                    Con.Open();
                }
                //Get the high-traffic dates
                SqlCommand command = new SqlCommand("GetDates", Con);
                SqlDataReader reader = command.ExecuteReader();
                List<highTrafficDates> htd = new List<highTrafficDates>();
                while (reader.Read())
                {
                    htd.Add(new highTrafficDates { ID = reader.GetInt32(0), date = reader.GetDateTime(1) });
                }
                Con.Close();
                //Compare the high-traffic dates to the reservation date
                for (int i = 0; i < htd.Count; i++)
                {
                    if (ParsedDate.Month == htd[i].date.Month && ParsedDate.Day == htd[i].date.Day)
                    {
                        return true;
                    }
                }
            }
            return false;
        }

        protected void sendEmail(List<int> tables)
        {
            System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12;
            string toUser = txtEmail.Text;
            string from = "joshuasrestaurant5@gmail.com";
            MailMessage messageUser = new MailMessage(from, toUser);
            MailMessage messageOwner = new MailMessage(from, from);

            messageUser.Subject = "Reservation Booked at Joshua's Restaurant";
            messageUser.Body = string.Format("Your reservation at Joshua's Restaurant has been booked." +
            "<br/><br/>Your name: {0}" +
            "<br/>Date: {1}" +
            "<br/>Start time: {2}" +
            "<br/>End time: {3}" +
            "<br/>Number of attendees: {4}" +
            "<br/><br/>Be aware that there is a $10 no-show fee." +
            "<br/><br/>Your table numbers are: ", txtName.Text, txtDate.Text, txtStart.Text, txtEnd.Text, txtNumParty.Text);
            messageUser.BodyEncoding = Encoding.UTF8;
            messageUser.IsBodyHtml = true;

            messageOwner.Subject = "Reservation Booked at Joshua's Restaurant";
            messageOwner.Body = string.Format("A reservation at Joshua's Restaurant has been booked." +
            "<br/><br/>Name: {0}" +
            "<br/>Date: {1}" +
            "<br/>Start time: {2}" +
            "<br/>End time: {3}" +
            "<br/>Number of attendees: {4}" +
            "<br/>Table numbers: ", txtName.Text, txtDate.Text, txtStart.Text, txtEnd.Text, txtNumParty.Text);

            for (int i = 0; i < tables.Count; i++)
            {
                messageUser.Body += tables[i] + " ";
                messageOwner.Body += tables[i] + " ";
            }

            if (isHighTraffic())
            {
                messageUser.Body += "<br/><br/>A holding fee has been applied to your card due to the reservation being on a high-traffic day.";
            }
            else
            {
                messageUser.Body += "<br/><br/>No holding fee has been applied for this reservation.";
            }

            messageOwner.BodyEncoding = Encoding.UTF8;
            messageOwner.IsBodyHtml = true;

            SmtpClient client = new SmtpClient("smtp.gmail.com", 587);
            client.Credentials = new NetworkCredential(from, "jykmgfshrndcyvsz");
            client.EnableSsl = true;
            try
            {
                client.Send(messageUser);
                client.Send(messageOwner);
            }

            catch (Exception ex)
            {
                throw ex;
            }
        }

        protected bool isRegistered()
        {
            return Session["UserName"] != null;
        }

        protected bool hasCreditCard()
        {
            if (!isRegistered())
            {
                return false;
            }
            string name = Session["UserName"].ToString();
            int ccid = 0;
            if (Con.State == ConnectionState.Closed)
            {
                Con.Open();
            }
            SqlCommand command = new SqlCommand("GetUserDetails", Con);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@Name", name);
            SqlDataReader reader = command.ExecuteReader();
            bool ret = false;
            if (reader.Read())
            {
                try
                {
                    ret = !reader.GetString(4).Equals("0");
                }
                catch
                {
                    ret = false;
                }
            }
            Con.Close();
            return ret;       //CCID returns as 0 when null in DB
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        public void Clear()
        {
            //hfEmployeeID.Value = "";
            txtName.Text = txtPhone.Text = txtEmail.Text = txtDate.Text = txtStart.Text = txtEnd.Text = txtNumParty.Text = "";
            lblErrorMessage.Text = "";
            //lblSuccessMessage.Text = lblErrorMessage.Text = "";
            autoFillFields();
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/SignIn.aspx");
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/SignUp.aspx");
        }

        protected void btnAddTable_Click(object sender, EventArgs e)
        {
            if (Con.State == ConnectionState.Closed)
            {
                Con.Open();
            }
            SqlCommand command = new SqlCommand("AddTable", Con);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@Capacity", 2);
            command.ExecuteNonQuery();
            Con.Close();
        }

        protected void OnConfirm(object sender, EventArgs e)
        {
            //Label7.Text = Request.Form["confirm_value"];
            //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Record Inserted Successfully')", true);
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('You clicked YES!')", true);
                //TODO Store session data
                //TODO Redirect to SignUp.aspx
            }
            else
            {

                this.Page.ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('You clicked NO!')", true);
            }
        }

        protected class availableTable
        {
            public int ID { get; set; }
            public int capacity { get; set; }
        }

        protected bool checkReservation(bool book)
        {
            lblSuccessMessage.Text = "";
            //Get integers representing time intervals
            DateTime ParsedDate, ParsedStart, ParsedEnd;
            int partySize;
            ParsedDate = DateTime.Parse(txtDate.Text);
            ParsedStart = DateTime.Parse(txtStart.Text);
            ParsedEnd = DateTime.Parse(txtEnd.Text);
            partySize = int.Parse(txtNumParty.Text);
            DateTime startTime = ParsedDate.Date.Add(ParsedStart.TimeOfDay);
            DateTime endTime = ParsedDate.Date.Add(ParsedEnd.TimeOfDay);

            //Get an array of the available tables within that interval and their capacities
            if (Con.State == ConnectionState.Closed)
            {
                Con.Open();
            }
            SqlCommand command = new SqlCommand("GetFreeTables", Con);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@StartTime", startTime);
            command.Parameters.AddWithValue("@EndTime", endTime);
            SqlDataReader reader = command.ExecuteReader();
            List<availableTable> tables = new List<availableTable>();
            //string tabs = "";
            ArrayList tabs = new ArrayList();
            while (reader.Read())
            {
                tables.Add(new availableTable { ID = reader.GetInt32(0), capacity = reader.GetInt32(1) });
                tabs.Add("TableID: " + reader.GetInt32(0) + "\tCapacity: " + reader.GetInt32(1));
            }
            //TablesLabel.Text = tabs;
            TablesListBox.DataSource = tabs;
            TablesListBox.DataBind();
            Con.Close();
            //Sort the tables by capacity
            tables.Sort(delegate (availableTable t1, availableTable t2) { return t2.capacity.CompareTo(t1.capacity); });
            int allocatedCapacity = 0;
            List<int> allocatedTableIDs = new List<int>();

            //Allocate tables greedily to get us at or near satisfying the party size
            for (int i = 0; i < tables.Count; i++)
            {
                if (allocatedCapacity + tables[i].capacity <= partySize)
                {
                    allocatedCapacity += tables[i].capacity;
                    allocatedTableIDs.Add(tables[i].ID);
                    tables.Remove(tables[i]);
                    i--;
                    if (allocatedCapacity == partySize)
                    {
                        break;
                    }
                }
            }
            //Add the smallest table which gets us at/over the party size
            if (allocatedCapacity < partySize)
            {
                for (int i = tables.Count - 1; i >= 0; i--)
                {
                    if (allocatedCapacity + tables[i].capacity >= partySize)
                    {
                        allocatedCapacity += tables[i].capacity;
                        allocatedTableIDs.Add(tables[i].ID);
                        break;
                    }
                }
            }
            //If we can satisfy the party's request
            if (allocatedCapacity >= partySize)
            {
                if (!book) { return true; }
                //Book
                if (Con.State == ConnectionState.Closed)
                {
                    Con.Open();
                }
                SqlCommand sqlCmd = new SqlCommand("dbo.AddReservation_Fixed", Con);
                sqlCmd.CommandType = CommandType.StoredProcedure;
                sqlCmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                sqlCmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
                sqlCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                sqlCmd.Parameters.AddWithValue("@Date", ParsedDate);
                sqlCmd.Parameters.AddWithValue("@StartTime", startTime);
                sqlCmd.Parameters.AddWithValue("@EndTime", endTime);
                sqlCmd.Parameters.AddWithValue("@NoParty", partySize);
                //sqlCmd.ExecuteNonQuery();
                SqlDataReader reader2 = sqlCmd.ExecuteReader();
                int reservationID;
                try
                {
                    reader2.Read();
                    reservationID = (int)reader2.GetDecimal(0);
                }
                catch (Exception ex)
                {
                    throw ex;
                }
                reader2.Close();
                //Add to junction table
                SqlCommand sqlCmd2 = new SqlCommand("dbo.AddReservation_Fixed_Add_Junction", Con);
                sqlCmd2.CommandType = CommandType.StoredProcedure;
                sqlCmd2.Parameters.AddWithValue("@ReservationID", reservationID);
                for (int i = 0; i < allocatedTableIDs.Count; i++)
                {
                    sqlCmd2.Parameters.AddWithValue("@TableID", allocatedTableIDs[i]);
                    sqlCmd2.ExecuteNonQuery();
                    sqlCmd2.Parameters.RemoveAt("@TableID");
                }
                Con.Close();
                sendEmail(allocatedTableIDs);
                lblSuccessMessage.Text = "Reservation booked successfully. Be aware that there is a $10 no-show fee." + (isHighTraffic() ? " A hold fee has been applied (high-traffic day)." : "");

                Clear();

                return true;    //SQL command was successful
            }
            return false;   //Could not allocate sufficient table space in the specified interval
        }

        /*protected void btnBook_Click(object sender, EventArgs e)
        {
            if (Con.State == ConnectionState.Closed)
            {
                Con.Open();
            }

            SqlCommand sqlCmd = new SqlCommand("dbo.NewReservation", Con);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            //sqlCmd.Parameters.AddWithValue("@ReservationID", 0);
            //sqlCmd.Parameters.AddWithValue("@Name", Session["Name"]);
            sqlCmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@Date", txtDate.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@StartTime", txtStart.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@EndTime", txtEnd.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@NoParty", txtNumParty.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@TableID", 0);
            sqlCmd.Parameters.AddWithValue("@TrafficDayID", 0);

            //Con.Open();
            sqlCmd.ExecuteNonQuery();
            Con.Close();

            Clear();
            lblSuccessMessage.Text = "Saved Successfully";
        }*/

        protected void btnBook_Click(object sender, EventArgs e)
        {
            if(!Page.IsValid) { return; }
            //Check if the user is unregistered AND wants to register
            string confirmValue = Request.Form["confirm_value"];
            if (confirmValue == "Yes")
            {
                //TODO Store session data
                //Redirect to SignUp.aspx
                Response.Redirect("~/SignUp.aspx");
                return;
            }
            //Else: perform the booking.

            //If the specified date is not high-traffic or if the user has a credit card on file, the reservation can be performed.
            if (!isHighTraffic() || hasCreditCard())
            //if(true)
            {
                //Check if a reservation can be performed without actually adding it.
                if (checkReservation(false))
                {
                    CanReserveLabel.Visible = false;
                    checkReservation(true);
                }
                else
                {
                    CanReserveLabel.Text = "Cannot perform reservation: insufficient table space.";
                    CanReserveLabel.Visible = true;
                }
            }
            else
            {
                CanReserveLabel.Text = "Cannot perform reservation: high-traffic and no credit card on file.";
                CanReserveLabel.Visible = true;
            }
        }

        protected void btnCheck_Click(object sender, EventArgs e)
        {
            //TODO List available tables
            //Get integers representing time intervals
            DateTime ParsedDate, ParsedStart, ParsedEnd;
            int partySize;
            ParsedDate = DateTime.Parse(txtDate.Text);
            ParsedStart = DateTime.Parse(txtStart.Text);
            ParsedEnd = DateTime.Parse(txtEnd.Text);
            partySize = int.Parse(txtNumParty.Text);
            DateTime startTime = ParsedDate.Date.Add(ParsedStart.TimeOfDay);
            DateTime endTime = ParsedDate.Date.Add(ParsedEnd.TimeOfDay);

            //Get an array of the available tables within that interval and their capacities
            if (Con.State == ConnectionState.Closed)
            {
                Con.Open();
            }
            SqlCommand command = new SqlCommand("GetFreeTables", Con);
            command.CommandType = CommandType.StoredProcedure;
            command.Parameters.AddWithValue("@StartTime", startTime);
            command.Parameters.AddWithValue("@EndTime", endTime);
            SqlDataReader reader = command.ExecuteReader();
            List<availableTable> tables = new List<availableTable>();
            //string tabs = "";
            ArrayList tabs = new ArrayList();
            while (reader.Read())
            {
                tables.Add(new availableTable { ID = reader.GetInt32(0), capacity = reader.GetInt32(1) });
                tabs.Add("TableID: " + reader.GetInt32(0) + "\tCapacity: " + reader.GetInt32(1));
            }
            //TablesLabel.Text = tabs;
            TablesListBox.DataSource = tabs;
            TablesListBox.DataBind();
            Con.Close();
        }


        protected void txtStart_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtEnd_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtNumParty_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtDate_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtName_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtPhone_TextChanged(object sender, EventArgs e)
        {

        }

        protected void txtEmail_TextChanged(object sender, EventArgs e)
        {

        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Home.aspx");
        }
    }
}