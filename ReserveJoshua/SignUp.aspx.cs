using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Runtime.Remoting.Messaging;

namespace ReserveJoshua
{
    public partial class SignUp : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (TextBox1 == null)
            {
                Response.Redirect("~/SignUp.aspx.");
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            SqlConnection Con = new SqlConnection("Server=tcp:joshuascuisine.database.windows.net,1433;Initial Catalog=JoshuasCuisine;Persist Security Info=False;User ID=derni;Password=$84u3r!duff!w1ck01dt$;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");
            {
                SqlCommand insertE = new SqlCommand("EXEC dbo.StoredLogIn @Email, @Name, @PassWord, @SecurityQuestion, @SecurityAnswer", Con);
                insertE.Parameters.AddWithValue("@Email", TextBox11.Text);
                insertE.Parameters.AddWithValue("@Name", TextBox15.Text);
                insertE.Parameters.AddWithValue("@PassWord", TextBox12.Text);
                insertE.Parameters.AddWithValue("@SecurityQuestion", TextBox13.Text);
                insertE.Parameters.AddWithValue("@SecurityAnswer", TextBox14.Text);

                SqlCommand insertFN = new SqlCommand("EXEC dbo.NewMember @Name, @MailingAddress, @BillingAddress, @Phone, @Cell, @Email, @PreferredPaymentMethod, @CCID", Con);
                
                insertFN.Parameters.AddWithValue("@Name", TextBox1.Text);
                insertFN.Parameters.AddWithValue("@MailingAddress", TextBox4.Text);
                insertFN.Parameters.AddWithValue("@BillingAddress", txtBilling.Text);
                insertFN.Parameters.AddWithValue("@Phone", TextBox9.Text);
                insertFN.Parameters.AddWithValue("@Cell", TextBox10.Text);
                insertFN.Parameters.AddWithValue("@Email", TextBox11.Text);
                insertFN.Parameters.AddWithValue("@PreferredPaymentMethod", DropDownList1.Text);

                SqlCommand insertCC = new SqlCommand("EXEC dbo.CreditCardStoredInfo @CreditCardType, @CreditCardNum, @ExperationDate, @CVVNum", Con);
                insertCC.Parameters.AddWithValue("@CreditCardType", DropDownList1.Text);
                if (txtCCNum.Text != "")
                {
                    insertCC.Parameters.AddWithValue("@CreditCardNum", txtCCNum.Text);
                    insertCC.Parameters.AddWithValue("@ExperationDate", DateTime.Parse(txtCCDate.Text));
                    insertCC.Parameters.AddWithValue("@CVVNum", txtCVV.Text);
                }
                else
                {
                    insertCC.Parameters.AddWithValue("@CreditCardNum", 0);
                    insertCC.Parameters.AddWithValue("@ExperationDate", DateTime.Parse("01/01"));
                    insertCC.Parameters.AddWithValue("@CVVNum", "000");

                }
                Con.Open();

                insertE.ExecuteNonQuery();
                SqlDataReader reader = insertCC.ExecuteReader();
                int CCID;
                try
                {
                    reader.Read();
                    CCID = (int)reader.GetDecimal(0);
                }
                catch (Exception ex)
                {
                    CCID = 15;
                }
                reader.Close();
                insertFN.Parameters.AddWithValue("@CCID", CCID);
                insertFN.ExecuteNonQuery();
                Con.Close();
            }

            if (IsPostBack)
            {
                Response.Redirect("~/SignIn.aspx");
            }

        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            Response.Redirect("~/Home.aspx");
        }
    }
}