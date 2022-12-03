<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EmployeeLogIn.aspx.cs" Inherits="ReserveJoshua.EmployeeLogIn" %>

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
            <br />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;
         <asp:HiddenField ID="hfEmail" runat="server" />
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <table style="margin:auto; border:5px solid white">
                <tr>
                    <td>
                        <asp:Label ID="Label1" runat="server" Text="Username" BackColor="White"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtUserName" runat="server" ></asp:TextBox></td>
                </tr>
                <tr>
                    <td>
                        <asp:Label ID="Label2" runat="server" Text="Password" BackColor="White"></asp:Label></td>
                    <td>
                        <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Button ID="btnSignIn" runat="server" Text="Signin" OnClick="btnSignIn_Click" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Label ID="lblErrorMessage" runat="server" Text="Your login attempt was not successful. Please try again." ForeColor="Red" BackColor="#BCCEDC"></asp:Label></td>
                </tr>
            </table>
            <br />
            <br />
            <br />
            <br />
            <asp:TemplateField>
               <ItemTemplate>
                  <asp:LinkButton ID="lnkView" runat="server" CommandArgument='<%# Eval("EmployeeID") %>' OnClick="lnk_OnClick"></asp:LinkButton>
               </ItemTemplate>
            </asp:TemplateField>
            <br />
            <br />

            <table style="margin:auto; border:5px solid white">
                <tr>
                    <td>
                        <asp:Label ID="Label3" runat="server" Text="Forgot Your Password?" BackColor="White" Width="562px" Font-Size="Medium" Height="23px" Font-Bold="True" ForeColor="Black"></asp:Label><br />
                    </td>
                </tr>
            </table>
            <table style="margin:auto; border:5px solid white">
                <tr>
                    <td>
                        <asp:Label ID="Label4" runat="server" Text="Enter Your Security Question Answer To Receive Your Password." BackColor="White" Width="562px" Font-Bold="True" Font-Size="Medium" ForeColor="Black"></asp:Label>
                    </td>
                </tr>
            </table>
             <table style="margin:auto; border:5px solid white">
                <tr>
                    <td>
                        <asp:Label ID="Label5" runat="server" Text="Answer:" BackColor="White" Width="72px" Font-Bold="True" Font-Size="Medium" ForeColor="Black"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtAnswer" runat="server" Width="478px"></asp:TextBox>
                    </td>
                </tr>
                <tr>
                    <td>
                       
                    </td>
                    <td colspan="2">
                        <asp:Button ID="btnSend" runat="server" Text="Send" OnClick="btnSend_Click" Font-Bold="True" />
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        <asp:Label ID="lblError" runat="server" Text="Your Answer Was Incorrect. Please try again." ForeColor="Red" BackColor="#BCCEDC"></asp:Label></td>
                </tr>
            </table>
            <table style="margin:auto; border:5px solid white">
                 <tr>
                    <td>
                        <asp:Label ID="Label6" runat="server" Text="New Password:" BackColor="White"></asp:Label>
                    </td>
                    <td colspan="2">
                        <asp:TextBox ID="txtNewPassword" runat="server" Width="452px"></asp:TextBox>
                    </td>
                </tr>
                  <tr>
                    <td>
                        
                    </td>
                    <td colspan="2">
                        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSend_Click" />
                    </td>
                </tr>
                <tr>
                    <td>
                        
                    </td>
                    <td colspan="2">
                        <asp:Label ID="lblSuccess" runat="server" Text="" ForeColor="Green"></asp:Label>
                    </td>
                </tr>
            </table>
            <br />
            <br />
            <br />
&nbsp;&nbsp;
            <br />
&nbsp;&nbsp;<asp:Button ID="Button1" runat="server" BackColor="#416A98" Font-Bold="True" ForeColor="Black" OnClick="Button1_Click" Text="Manager Signin" />
        &nbsp;
        </form>
</body>
</html>