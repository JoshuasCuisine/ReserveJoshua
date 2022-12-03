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
    public partial class LookTesting : System.Web.UI.Page
    {
        SqlConnection Con = new SqlConnection("Server=tcp:joshuascuisine.database.windows.net,1433;Initial Catalog=JoshuasCuisine;Persist Security Info=False;User ID=derni;Password=$84u3r!duff!w1ck01dt$;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;");

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Redirect("~Home.aspx");
        }
    }
}