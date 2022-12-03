<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="ReserveJoshua.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
<script language="C#" runat="server">

      void ImageButton_Click(object sender, ImageClickEventArgs e) 
      {
         Response.Redirect("~/Home.aspx");
      }

   </script>
    <style type="text/css">
        *{
            margin:0;
            padding:0;
            font-family:'Lucida Sans', 'Lucida Sans Regular', 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif;
            font-style:italic;
        }
        .headerBackground{
            background:url(Images/Top_Border_Color.png) no-repeat;
            height: 60px;
        }
        .banner{
           background-image:url(Images/Banner.png);
           width:100%;
           height:140px;
        }
        .topBanner{
            display:grid;
            grid-template-columns: 15% 85%; 
        }
        .topBannerRight{
            display:flex;
            justify-content:space-between; 
            align-items:center;
            padding:10px;
        }
        .addressNumber{
            text-decoration:none;
            color:white;
        }
        .addressNumber:hover,.navItem:hover{
            cursor:pointer;
            text-decoration:underline;
        }
        .name{
            font-size:40px;
            color:white;
        }
        .navbar{
            display:flex;
            align-items:center;
            justify-content:space-around;
            font-size:20px;
        }
        .navItem{
            color:white;
            text-decoration:none;
        }
        /*end of header*/
        .center{
            display:flex;
            padding:15px;
        }
        .bar1{
            justify-content:space-around; 
        }
        .image{
            justify-content:center;
            align-items:center;
        }
        .bar2{
            justify-content:space-around; 
        }
        .welcome{
            margin-bottom:20px;
            margin-top:20px;
            font-size:40px;
            text-align:center;
            font-style:italic;
        }
        
        .button:hover{
             background-color:#e9ecf0d1;
        }
        .button{
            width:150px;
            height:55px;
            border:none;
            border-radius:5px;
            background-color:#e9ecf0;
            font-size:17px;
            font-weight:600;
            cursor:pointer;
        }
        #Image1{
            border-radius:50px;
            
        }
        
        
    </style>
</head>
<body>
    <form id="form1" runat="server">
            <header>
        <div class="headerBackground topBanner">
            <asp:ImageButton ID="ImageButton1" runat="server" Height="60px" Width="100%" ImageUrl="~/Images/Reservation_Logo.png" OnClick="ImageButton_Click"/>
            <div class="topBannerRight">
                <asp:LinkButton class="addressNumber" runat="server" 
                OnClientClick="javascript:window.open('https://www.google.com/maps/place/Ocean+Dr,+Beach+City,+TX+77523/@29.6712894,-94.8778038,17z/data=!3m1!4b1!4m6!3m5!1s0x863f681254268a9f:0x8b50b6de71723a06!8m2!3d29.6712894!4d-94.8756151!16s%2Fg%2F1tdk5kbz');" 
                >888 Ocean Front Dr., Beach City, Texas 77551<br />555-555-5555</asp:LinkButton>
                <p class="name">Joshua's Cuisine</p>
            </div>
        </div>
        <hr style="color:white;"/>
        <div class="headerBackground navbar">
            <a class="navItem" href="Home.aspx">Home</a>
            <a class="navItem" href="ReservationPortal.aspx">Reserve</a>
            <a class="navItem" href="SignIn.aspx">Sign In</a>
            <a class="navItem" href="SignUp.aspx">Sign Up</a>
        </div> 
        <hr style="color:white;"/>
        <canvas class="banner"></canvas> 
    </header>
    <div class="center image">
        </div>
        <div class="center bar2">
        </div>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <div>
            <asp:HiddenField ID="hfPreferredDiner" runat="server" />
            <br />
            <asp:Button ID="btnMakeReservation" runat="server" BackColor="#9BC9D5" 
                Font-Bold="True" Font-Size="Large" ForeColor="Black" OnClick="btnMakeReservation_Click" 
                Text="Make A Reservation" />
            <br />
            <br />
            <br />
            <br />
            <asp:GridView ID="gvContact" runat="server" AutoGenerateColumns="false" 
                Width="1290px">
                <Columns>
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="MailingAddress" HeaderText="MailingAddress" />
                    <asp:BoundField DataField="BillingAddress" HeaderText="BillingAddress" />
                    <asp:BoundField DataField="Phone" HeaderText="Phone" />
                    <asp:BoundField DataField="Cell" HeaderText="Cell" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="PointsEarned" HeaderText="PointsEarned" />
                    <asp:BoundField DataField="PreferredPaymentMethod" HeaderText="PreferredPaymentMethod" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkView" runat="server" CommandArgument='<%# Eval("PreferredDiner") %>' OnClick="lnk_OnClick"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
            <br />
            <asp:Label ID="Label5" runat="server" Font-Bold="True" ForeColor="Black" Text="Update Personal Information:"></asp:Label>
            <br />
            <table>
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="Name"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtName" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="MailingAddress"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtMailingAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="BillingAddress"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtBillingAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="Phone"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text="Cell"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtCell" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label7" runat="server" Text="Email"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label8" runat="server" Text="PointsEarned"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtPointsEarned" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label9" runat="server" Text="PreferredPaymentMethod"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtPreferredPaymentMethod" runat="server"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                        
                    </td>
                    <td colspan="2">
                        <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                        
                    </td>
                    <td colspan="2">
                        <asp:Label ID="lblSuccessMessage" runat="server" Text="" ForeColor="Green"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        
                    </td>
                    <td colspan="2">
                        <asp:Label ID="lblErrorMessage" runat="server" Text="" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <asp:ChangePassword ID="ChangePassword1" runat="server"></asp:ChangePassword>
            <br />
            <br />
            
        </div>
        <div>
            <br />
            <br />
            <br />
            <br />
            <br />
            <br />
            <asp:Label ID="lblUserDetails" runat="server" Text=""></asp:Label>
            <br />
            <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click" />
        </div>
    </form>
</body>
</html>
