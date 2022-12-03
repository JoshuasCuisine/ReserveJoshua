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
    public partial class Dashboard : System.Web.UI.Page
    {
        SqlConnection Con = new SqlConnection("Server=tcp:joshuascuisine.database.windows.net,1433;Initial Catalog=JoshuasCuisine;Persist Security Info=False;User ID=derni;Password=$84u3r!duff!w1ck01dt$;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FillGridView();
            }


            if (Session["UserName"] == null)
            {
                Response.Redirect("~/SignIn.aspx");
            }
            lblUserDetails.Text = "UserName : " + Session["UserName"];
            //else "sign up"
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Redirect("~/SignIn.aspx");
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Home.aspx");
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            Clear();
        }

        public void Clear()
        {
            hfPreferredDiner.Value = "";
            txtName.Text = txtMailingAddress.Text = txtBillingAddress.Text = txtPhone.Text = txtCell.Text =
                txtEmail.Text = txtPointsEarned.Text = txtPreferredPaymentMethod.Text = "";
            lblSuccessMessage.Text = lblErrorMessage.Text = "";
            btnSave.Text = "Save";
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (Con.State == ConnectionState.Closed)
            {
                Con.Open();
            }
            SqlCommand sqlCmd = new SqlCommand("dbo.ContactUpdate", Con);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@PreferredDiner", (hfPreferredDiner.Value == "" ? 0 : Convert.ToInt32(hfPreferredDiner.Value)));
            sqlCmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@MailingAddress", txtMailingAddress.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@BillingAddress", txtBillingAddress.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@Phone", txtPhone.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@Cell", txtCell.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
            sqlCmd.Parameters.AddWithValue("@PreferredPaymentMethod", txtPreferredPaymentMethod.Text.Trim());
            sqlCmd.ExecuteNonQuery();
            Con.Close();
            string memberID = hfPreferredDiner.Value;
            Clear();

            if (memberID == "")
            {
                lblSuccessMessage.Text = "Saved Successfully";
            }
            else
            {
                lblSuccessMessage.Text = "Updated Successfully";
            }
            FillGridView();
        }

        void FillGridView()
        {
            if (Con.State == ConnectionState.Closed)
            {
                Con.Open();
            }

            SqlDataAdapter sqlDa = new SqlDataAdapter("ContactView", Con);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            Con.Close();
            gvContact.DataSource = dtbl;
            gvContact.DataBind();
        }

        protected void lnk_OnClick(object sender, EventArgs e)
        {
            int contactID = Convert.ToInt32((sender as LinkButton).CommandArgument);

            if (Con.State == ConnectionState.Closed)
            {
                Con.Open();
            }

            SqlDataAdapter sqlDa = new SqlDataAdapter("ContactView", Con);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlDa.SelectCommand.Parameters.AddWithValue("@PreferredDiner", contactID);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            Con.Close();

            hfPreferredDiner.Value = contactID.ToString();
            txtName.Text = dtbl.Rows[0]["Name"].ToString();
            txtMailingAddress.Text = dtbl.Rows[0]["MailingAddress"].ToString();
            txtBillingAddress.Text = dtbl.Rows[0]["BillingAddress"].ToString();
            txtPhone.Text = dtbl.Rows[0]["Phone"].ToString();
            txtCell.Text = dtbl.Rows[0]["Cell"].ToString();
            txtEmail.Text = dtbl.Rows[0]["Email"].ToString();
            txtPointsEarned.Text = dtbl.Rows[0]["PointsEarned"].ToString();
            txtPreferredPaymentMethod.Text = dtbl.Rows[0]["PreferredPaymentMethod"].ToString();

            btnSave.Text = "Update";
            //btnDelete.Enabled = true;
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

        }

        protected void btnMakeReservation_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Reservations.aspx");
        }
    }
}