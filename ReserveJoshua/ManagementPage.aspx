<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManagementPage.aspx.cs" Inherits="ReserveJoshua.ManagementPage" %>

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
        /*end of header*/
        .welcome{
            margin-bottom:50px;
            margin-top:50px;
            font-size:40px;
            text-align:center;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <header>
        <div class="headerBackground topBanner">
            <asp:ImageButton ID="ImageButton1" runat="server" Height="60px" Width="100%" ImageUrl="~/Images/Reservation_Logo.png"/>
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
       
        <h1 class="welcome">View, Add, Edit, Delete Employees</h1>

        <div>
        <asp:HiddenField ID="hfEmployeeID" runat="server" />
        <table style="margin:auto; border:5px solid white">
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
                    <asp:Label ID="Label2" runat="server" Text="Address"></asp:Label>
                </td>
                <td colspan="2">
                    <asp:TextBox ID="txtAddress" runat="server" TextMode="MultiLine"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label3" runat="server" Text="Phone"></asp:Label>
                </td>
                <td colspan="2">
                    <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="Label4" runat="server" Text="Email"></asp:Label>
                </td>
                <td colspan="2">
                    <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                </td>
            </tr>
           
            <tr>
                <td>
                    
                </td>
                <td colspan="2">
                    <asp:Button ID="btnSave" runat="server" Text="Save" OnClick="btnSave_Click" />
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" />
                    <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" />
                </td>
            </tr>
            <tr>
                <td>
                    
                </td>
                <td colspan="2">
                    <asp:Label ID="lblSuccessMessage" runat="server" Text="" ForeColor="Green" Font-Bold="true"></asp:Label>
                </td>
                </tr>
            <tr>
                <td>
                    
                </td>
                <td colspan="2">
                    <asp:Label ID="lblErrorMessage" runat="server" Text="" ForeColor="Red" Font-Bold="true"></asp:Label>
                </td>
            </tr>
            <tr>
            </tr>
        </table>
        <br />
        <asp:GridView style="margin:auto" ID="gvEmployee" runat="server" AutoGenerateColumns="false" Width="674px">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="Address" HeaderText="Address" />
                <asp:BoundField DataField="Phone" HeaderText="Phone" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:LinkButton ID="lnkView" runat="server" CommandArgument='<%# Eval("EmployeeID") %>' OnClick="lnk_OnClick">View</asp:LinkButton>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
    </form>
</body>
</html>
