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
    public partial class ManagementLogIn : System.Web.UI.Page
    {
        SqlConnection Con = new SqlConnection("Server=tcp:joshuascuisine.database.windows.net,1433;Initial Catalog=JoshuasCuisine;Persist Security Info=False;User ID=derni;Password=$84u3r!duff!w1ck01dt$;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
        protected void Page_Load(object sender, EventArgs e)
        {
            lblErrorMessage.Visible = false;
            lblError.Visible = false;
            Label6.Visible = false;
            txtNewPassword.Visible = false;
            btnSubmit.Visible = false;
        }

        public void Clear()
        {
            hfManagerID.Value = "";
            txtNewPassword.Text = "";
            lblSuccess.Text = lblError.Text = "";
            btnSubmit.Text = btnSend.Text = "Save";
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            if (Con.State == ConnectionState.Closed)
            {
                Con.Open();
            }

            string query = "SELECT COUNT(1) FROM ManagerLogIn WHERE UserName=@UserName AND PassWord=@PassWord";
            SqlCommand authorize = new SqlCommand(query, Con);
            authorize.Parameters.AddWithValue("@UserName", txtUserName.Text.Trim());
            authorize.Parameters.AddWithValue("@PassWord", txtPassword.Text.Trim());
            int count = Convert.ToInt32(authorize.ExecuteScalar());
            if (count == 1)
            {
                Session["UserName"] = txtUserName.Text.Trim();
                Response.Redirect("~/ManagementPage.aspx");
            }
            else
            {
                lblErrorMessage.Visible = true;
            }

            Con.Close();
        }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            if (Con.State == ConnectionState.Closed)
            {
                Con.Open();
            }

            string query = "SELECT COUNT(1) FROM ManagerLogIn WHERE SecurityAnswer=@SecurityAnswer";
            SqlCommand authorize = new SqlCommand(query, Con);
            authorize.Parameters.AddWithValue("@SecurityAnswer", txtAnswer.Text.Trim());
            int count = Convert.ToInt32(authorize.ExecuteScalar());
            if (count == 1)
            {
                Session["SecurityAnswer"] = txtAnswer.Text.Trim();
                Label3.Visible = false;
                Label4.Visible = false;
                Label5.Visible = false;
                txtAnswer.Visible = false;
                Label6.Visible = true;
                txtNewPassword.Visible = true;
                btnSubmit.Visible = true;
                btnSubmit_Click(sender, e);
            }
            else
            {
                lblError.Visible = true;
            }

            Con.Close();
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            if (Con.State == ConnectionState.Closed)
            {
                Con.Open();
            }

            SqlCommand sqlCmd = new SqlCommand("dbo.MgrUpdatePassWord", Con);
            sqlCmd.CommandType = CommandType.StoredProcedure;
            sqlCmd.Parameters.AddWithValue("@Email", (hfManagerID.Value == "" ? 0 : Convert.ToInt32(hfManagerID.Value)));
            sqlCmd.Parameters.AddWithValue("@PassWord", txtNewPassword.Text.Trim());
            sqlCmd.ExecuteNonQuery();
            Con.Close();
            string memberID = hfManagerID.Value;
            Clear();

            if (memberID == "")
            {
                lblSuccess.Text = "Saved Successfully";
            }
            else
            {
                lblSuccess.Text = "Updated Successfully";
            }

            Con.Close();
        }

        protected void lnk_OnClick(object sender, EventArgs e)
        {
            int contactID = Convert.ToInt32((sender as LinkButton).CommandArgument);

            if (Con.State == ConnectionState.Closed)
            {
                Con.Open();
            }

            SqlDataAdapter sqlDa = new SqlDataAdapter("MgrContactView", Con);
            sqlDa.SelectCommand.CommandType = CommandType.StoredProcedure;
            sqlDa.SelectCommand.Parameters.AddWithValue("@Email", contactID);
            DataTable dtbl = new DataTable();
            sqlDa.Fill(dtbl);
            Con.Close();

            hfManagerID.Value = contactID.ToString();
            txtNewPassword.Text = dtbl.Rows[0]["PassWord"].ToString();
            btnSubmit.Text = "Update";
            //btnDelete.Enabled = true;
        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Home.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/ManagementPage.aspx");
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

        }
    }
}