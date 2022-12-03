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
    public partial class ManagerSignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Home.aspx");
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlConnection Con = new SqlConnection("Server=tcp:joshuascuisine.database.windows.net,1433;Initial Catalog=JoshuasCuisine;Persist Security Info=False;User ID=derni;Password=$84u3r!duff!w1ck01dt$;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
            {
                SqlCommand insertE = new SqlCommand("EXEC dbo.MgrLogIn @Email, @UserName, @PassWord, @SecurityQuestion, @SecurityAnswer", Con);
                insertE.Parameters.AddWithValue("@Email", TextBox11.Text);
                insertE.Parameters.AddWithValue("@UserName", TextBox15.Text);
                insertE.Parameters.AddWithValue("@PassWord", TextBox12.Text);
                insertE.Parameters.AddWithValue("@SecurityQuestion", TextBox13.Text);
                insertE.Parameters.AddWithValue("@SecurityAnswer", TextBox14.Text);

                Con.Open();
                insertE.ExecuteNonQuery();
                Con.Close();
            }

            if (IsPostBack)
            {
                Response.Redirect("~/ManagementLogIn.aspx");
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

        }
    }
}