<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManagerSignUp.aspx.cs" Inherits="ReserveJoshua.ManagerSignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
        /*END OF HEADER*/
        .title{
            margin-top:20px;
            font-size:30px;
            text-align:center;
            margin-bottom:30px;
        }
        .container{
            width:100%;
            display:flex;
            justify-content:center;
        }
        .grid{
            display:grid;
            grid-template-columns: 250px 300px;
            margin-bottom:30px;
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
        .t{
            margin:5px;
        }
        .label{
            font-size:15px;
            padding:5px;
            margin:5px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <header>
        <div class="headerBackground topBanner">
            <asp:ImageButton ID="ImageButton1" runat="server" Height="60px" Width="100%" ImageUrl="~/Images/Reservation_Logo.png" />
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
            <h1 class="title">Create a Manager Profile</h1>      
        <div class="container">
            <div class="grid">
                <asp:Label class="label" ID="Label12" runat="server" Text="Employee Email" ></asp:Label>
                <asp:TextBox ID="TextBox11" class="t" runat="server" ></asp:TextBox>
                <asp:Label class="label" ID="Label17" runat="server" Text="Create a User Name" ></asp:Label>
                <asp:TextBox ID="TextBox15" class="t" runat="server" ></asp:TextBox>
                <asp:Label class="label" ID="Label14" runat="server" Text="Create a Password" ></asp:Label>
                <asp:TextBox ID="TextBox12" class="t" runat="server" ></asp:TextBox>        
                <asp:Label class="label" ID="Label15" runat="server" Text="Create a Security Question" ></asp:Label>
                <asp:TextBox ID="TextBox13" class="t" runat="server" ></asp:TextBox>
                <asp:Label class="label" ID="Label16" runat="server" Text="Security Question Answer" ></asp:Label>
                <asp:TextBox ID="TextBox14" class="t" runat="server" ></asp:TextBox>              
            </div>
        </div>      
        <div class="container">
            <asp:Button ID="Button1" runat="server"  OnClick="Button1_Click" Text="Submit" class="button"/>
        </div>
    </form>
</body>
</html>
