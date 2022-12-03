using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace ReserveJoshua
{
    public partial class Reports : System.Web.UI.Page
    {
        SqlConnection Con = new SqlConnection("Server=tcp:joshuascuisine.database.windows.net,1433;Initial Catalog=JoshuasCuisine;Persist Security Info=False;User ID=derni;Password=$84u3r!duff!w1ck01dt$;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                btnDelete.Enabled = false;
                FillGridView();
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        public void Clear()
        {
            hfReservationID.Value = "";
            txtName.Text = txtPhone.Text = txtCell.Text = txtEmail.Text = 
                txtDate.Text = txtTime.Text = txtNoParty.Text = txtTableID.Text = "";
            lblSuccessMessage.Text = lblErrorMessage.Text = "";
            btnSave.Text = "Save";
            btnDelete.Enabled = false;
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Con.State == ConnectionState.Closed)
                Con.Open();
            SqlCommand sqlCmd = new SqlCommand("ReservationCreateOrUpdate", Con);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@ReservationID", (hfReservationID.Value == "" ? 0 : Convert.ToInt32(hfReservationID.Value)));
            sqlCmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@Address", txtPhone.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@Phone", txtCell.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@Cell", txtEmail.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@Date", txtDate.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@Time", txtTime.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@NoParty", txtNoParty.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@TableID", txtTableID.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@TrafficDayID", txtTableID.Text.Trim());
            sqlCmd.ExecuteNonQuery();
            Con.Close();
            string contactID = hfReservationID.Value;
            Clear();
            if (contactID == "")
                lblSuccessMessage.Text = "Saved Successfully";
            else
                lblSuccessMessage.Text = "Updated Successfully";
            FillGridView();
        }

        void FillGridView()
        {
            if (Con.State == ConnectionState.Closed)
                Con.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("ReservationList", Con);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            Con.Close();
            gvReservations.DataSource = dtbl;
            gvReservations.DataBind();

        }

        protected void lnk_OnClick(object sender, EventArgs e)
        {
            int contactID = Convert.ToInt32((sender as LinkButton).CommandArgument);
            if (Con.State == ConnectionState.Closed)
                Con.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("ReservationViewByID", Con);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlDa.SelectCommand.Parameters.AddWithValue("@ReservationID", contactID);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            Con.Close();
            hfReservationID.Value = contactID.ToString();
            hfReservationID.Value = dtbl.Rows[0]["ReservationID"].ToString();
            txtName.Text = dtbl.Rows[0]["Name"].ToString();
            txtPhone.Text = dtbl.Rows[0]["Address"].ToString();
            txtCell.Text = dtbl.Rows[0]["Phone"].ToString();
            txtEmail.Text = dtbl.Rows[0]["Email"].ToString();
            txtDate.Text = dtbl.Rows[0]["Name"].ToString();
            txtTime.Text = dtbl.Rows[0]["Address"].ToString();
            txtNoParty.Text = dtbl.Rows[0]["Phone"].ToString();
            txtTableID.Text = dtbl.Rows[0]["Email"].ToString();
            txtTrafficDayID.Text = dtbl.Rows[0]["TrafficDayID"].ToString();
            btnSave.Text = "Update";
            btnDelete.Enabled = true;
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            if (Con.State == ConnectionState.Closed)
                Con.Open();
            SqlCommand sqlCmd = new SqlCommand("ReservationDeleteByName", Con);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@Name", txtName.Text);
            sqlCmd.ExecuteNonQuery();
            Con.Close();
            Clear();
            FillGridView();
            lblSuccessMessage.Text = "Deleted Successfully";
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Home.aspx");
        }

        protected void btnEnter_Click(object sender, EventArgs e)
        {
            if (Con.State == ConnectionState.Closed)
                Con.Open();
            SqlCommand sqlCmd = new SqlCommand("ReservationsByDate", Con);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@Date", txtDateChosen.Text.Trim());
            sqlCmd.ExecuteNonQuery();
            Con.Close();
            string contactID = hfReservationID.Value;
            Clear();
            if (contactID == "")
                lblNoReservations.Text = "There are no reservations for the date selected.";
            else
                lblReservations.Text = "Reservations By Date:";
            FillGridView2();
        }
        void FillGridView2()
        {
            if (Con.State == ConnectionState.Closed)
                Con.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("ReservationsByDate", Con);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlDa.SelectCommand.Parameters.AddWithValue("@Date", txtDateChosen.Text.Trim());
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            Con.Close();
            GridView1.DataSource = dtbl;
            GridView1.DataBind();

        }
        protected void lnk2_OnClick(object sender, EventArgs e)
        {
            int contactID = Convert.ToInt32((sender as LinkButton).CommandArgument);
            if (Con.State == ConnectionState.Closed)
                Con.Open();
            SqlDataAdapter sqlDa = new SqlDataAdapter("ReservationsByDate", Con);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlDa.SelectCommand.Parameters.AddWithValue("@Date", txtDateChosen.Text);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            Con.Close();
            hfReservationID.Value = contactID.ToString();
            hfReservationID.Value = dtbl.Rows[0]["ReservationID"].ToString();
            txtName.Text = dtbl.Rows[0]["Name"].ToString();
            txtPhone.Text = dtbl.Rows[0]["Address"].ToString();
            txtCell.Text = dtbl.Rows[0]["Phone"].ToString();
            txtEmail.Text = dtbl.Rows[0]["Email"].ToString();
            txtDate.Text = dtbl.Rows[0]["Name"].ToString();
            txtTime.Text = dtbl.Rows[0]["Address"].ToString();
            txtNoParty.Text = dtbl.Rows[0]["Phone"].ToString();
            txtTableID.Text = dtbl.Rows[0]["Email"].ToString();
            txtTrafficDayID.Text = dtbl.Rows[0]["TrafficDayID"].ToString();
            btnSave.Text = "Update";
            btnDelete.Enabled = true;
        }

        protected void txtDateChosen_TextChanged(object sender, EventArgs e)
        {
            btnEnter_Click(sender, e);
        }

        protected void txtName_TextChanged(object sender, EventArgs e)
        {

        }
    }
}
