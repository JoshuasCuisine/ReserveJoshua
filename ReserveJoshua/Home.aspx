<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="ReserveJoshua.Home" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <title></title>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
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
        .carousel-inner img{
            margin: auto;
        }
        .auto-style1 {
            height: -42px;
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
        <div class="headerBackground navbar">
            <a class="navItem" href="Home.aspx">Home</a>
            <a class="navItem" href="ReservationPortal.aspx">Reserve</a>
            <a class="navItem" href="SignIn.aspx">Sign In</a>
            <a class="navItem" href="SignUp.aspx">Sign Up</a>
        </div> 
        <canvas class="banner"></canvas> 
    </header>
        <h1 class="welcome">Reservations: Quick and Easy</h1>

          <div>
            <div id="myCarousel" class="carousel slide" data-ride="carousel">
             <!-- Indicators -->
             <ol class="carousel-indicators">
                 <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
                 <li data-target="#myCarousel" data-slide-to="1"></li>
                 <li data-target="#myCarousel" data-slide-to="2"></li>
                 <li data-target="#myCarousel" data-slide-to="3"></li>
                 <li data-target="#myCarousel" data-slide-to="4"></li>
                 <li data-target="#myCarousel" data-slide-to="5"></li>
                 <li data-target="#myCarousel" data-slide-to="6"></li>
                 <li data-target="#myCarousel" data-slide-to="7"></li>
             </ol>
            <div class="carousel-inner" role="listbox">
                 <div class="active item">
                    <asp:Image ID="sldFirst" runat="server" src="Images/Reservation_Logo.png" alt="First slide" Height="360px" Width="888px" />
                 </div>
                <div class="item">
                    <asp:Image ID="sldSecond" runat="server" src="Carousel_Images/Food_Carousel_08.png" alt="Second Slide" Height="360px" Width="888px" />
                </div>
                <div class="item">
                    <asp:Image ID="sldThird" runat="server" src="Carousel_Images/Food_Carousel_02.png" alt="Third Slide" Height="360px" Width="888px" />
                </div>
                <div class="item">
                    <asp:Image ID="sldFourth" runat="server" src="Carousel_Images/Food_Carousel_06.png" alt="Fourth Slide" Height="360px" Width="888px" />
                </div>
                <div class="item">
                    <asp:Image ID="sldFifth" runat="server" src="Carousel_Images/Food_Carousel_03.png" alt="Fifth Slide" Height="360px" Width="888px" />
                </div>
                <div class="item">
                    <asp:Image ID="sldSixth" runat="server" src="Carousel_Images/Food_Carousel_04.png" alt="Sixth Slide" Height="360px" Width="888px" />
                </div>
                 <div class="item">
                    <asp:Image ID="sldSeventh" runat="server" src="Carousel_Images/Food_Carousel_05.png" alt="Seventh Slide" Height="360px" Width="888px" />
                 </div>
                <div class="item">
                    <asp:Image ID="sldEighth" runat="server" src="Carousel_Images/Food_Carousel_07.png" alt="Eighth Slide" Height="360px" Width="888px" />
                </div>
            </div>
      <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
        <span class="sr-only">Previous</span>
      </a>
      <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
        <span class="sr-only">Next</span>
      </a>
        </div><!-- /.carousel -->
        </div>
        <div class="center bar2">
            <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="Member Dashboard" class="button" style="width:200px"/>
            <asp:Button ID="Button5" runat="server" OnClick="Button5_Click" Text="Employee Login" class="button" style="width:200px"/>
        </div>
    </form>
</body>
</html>
