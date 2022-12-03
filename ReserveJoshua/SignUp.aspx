<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="ReserveJoshua.SignUp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script runat="server">
        void Check_Clicked(Object sender, EventArgs e)
        {
            if (checkBoxBilling.Checked) {
                txtBilling.Text = TextBox4.Text;
            } else {
                txtBilling.Text = "";
            }
            txtBilling.Enabled = !checkBoxBilling.Checked;
        }

        void MailingAddressChanged(Object sender, EventArgs args)
        {
            if (checkBoxBilling.Checked) {
                txtBilling.Text = TextBox4.Text;
            } else {
                txtBilling.Text = "";
            }
        }
    </script>
    <script type="text/javascript">
        function validateCreditCardCCV(sender, args) {
            if (document.getElementById('txtCCNum').value == "") { args.IsValid = true; return; }
            var patt = new RegExp("[^0-9]+");
            args.IsValid = !patt.test(args.Value);
        }

        function validateCreditCardExpiration(sender, args) {
            if (document.getElementById('txtCCNum').value == "") { args.IsValid = true; return; }
            var patt = new RegExp("^((0[1-9])|(1[0-2]))\/[0-9][0-9]$");
            args.IsValid = patt.test(args.Value);
        }

        function validateCreditCardNumber(sender, args) {
            if (args.Value == "") { return true; }
            var patt = new RegExp("[^0-9 -]+");
            if (patt.test(args.Value) == true) {
                args.IsValid = false;
            } else {
                var temp = String(args.Value).replace(/[^0-9]/g, "");
                if (temp.length < 10) {
                    args.IsValid = false;
                    return;
                }

                var s1 = 0;
                var s2 = 0;

                var reverse = temp.split("").reverse().join("");
                for (var i = 0; i < reverse.length; i++) {
                    var digit = parseInt(reverse.charAt(i), 10);
                    if (i % 2 == 0) {
                        s1 += digit;
                    } else {
                        s2 += 2 * digit;
                        if (digit >= 5) {
                            s2 -= 9;
                        }
                    }
                }

                args.IsValid = ((s1 + s2) % 10 == 0);
            }
        }
    </script>

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
        /*END OF HEADER*/
        .container{
            width:100%;
            display:flex;
            justify-content:center;
        }
        .grid{
            display:grid;
            grid-template-columns: 200px 300px;
            margin-bottom:20px;
        }
        .grid2{
            display:grid;
            grid-template-columns: 300px 500px;
            margin-bottom:20px;
        }
        .title{
            font-size:30px;
            font-style:italic;
            text-align:center;
            margin-bottom:20px;
        }
        .label{
            font-size:15px;
            padding:5px;
            font-style:italic;
            margin:5px;
        }
        #Button1{
            margin-top:10px;
            color:antiquewhite;
            text-decoration:none;
            text-align:center;
            width:150px;
            height:55px;
            border:none;
            border-radius:5px;
            background-color:#1859c9;
            font-size:17px;
            font-weight:600;
            cursor:pointer;
        }
        #Button1:hover{
            background-color:#1859c9db;
        }
        .t{
            margin:5px;
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
        <h1 class="title">Personal Information</h1>
        <div class="container">
            <div class="grid">
                <asp:Label ID="Label2" runat="server" Text="Full Name" class="label"></asp:Label>
                <asp:TextBox class="t" ID="TextBox1" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvName"
                        ControlToValidate="TextBox1"
                        Display="Dynamic"
                        ErrorMessage="Required field"
                        runat="server" />
                <asp:Label ID="Label1" runat="server" Text="Mailing Address" class="label"></asp:Label>
                <asp:TextBox class="t" ID="TextBox4" runat="server" AutoPostBack="true" OnTextChanged="MailingAddressChanged"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvMailingAddress"
                        ControlToValidate="TextBox4"
                        Display="Dynamic"
                        ErrorMessage="Required field"
                        runat="server" />
                <asp:Label ID="Label5" runat="server" Text="Billing Address" class="label"></asp:Label>
                <asp:TextBox class="t" ID="txtBilling" runat="server" ></asp:TextBox>
                <asp:CheckBox ID="checkBoxBilling" runat="server" Text="Same as Mailing" AutoPostBack="true" OnCheckedChanged="Check_Clicked"/>
                <asp:RequiredFieldValidator ID="rfvBillingAddress"
                        ControlToValidate="TextBox4"
                        Display="Dynamic"
                        ErrorMessage="Required field"
                        runat="server" />
                <asp:Label ID="Label10" runat="server" Text="Phone #" class="label"></asp:Label>
                <asp:TextBox class="t" ID="TextBox9" runat="server"   ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5"
                        ControlToValidate="TextBox9"
                        Display="Dynamic"
                        ErrorMessage="Required field"
                        runat="server" />
                <asp:RegularExpressionValidator ID="revPhone"
                        runat="server"
                        ErrorMessage="Enter a valid phone number."
                        ControlToValidate="TextBox9"
                        ValidationExpression="^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$"
                        Display="Dynamic">
                    </asp:RegularExpressionValidator>
                <asp:Label ID="Label11" runat="server" Text="Cell Phone" class="label" Visible="false"></asp:Label>
                <asp:TextBox class="t" ID="TextBox10" runat="server" Visible="false" ></asp:TextBox>
                <asp:Label ID="Label12" runat="server" Text="Email" class="label"></asp:Label>
                <asp:TextBox class="t" ID="TextBox11" runat="server"  ></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEmail"
                        ControlToValidate="TextBox11"
                        Display="Dynamic"
                        ErrorMessage="Required field"
                        runat="server" />
                <asp:RegularExpressionValidator ID="revEmail" 
                        runat="server" 
                        ErrorMessage="Enter a valid email address." 
                        ControlToValidate="TextBox11" 
                        ValidationExpression="[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-zA-Z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9-]*[a-zA-Z0-9])?"
                        Display="Dynamic">
                    </asp:RegularExpressionValidator>
                <div></div>
                <asp:DropDownList ID="DropDownList1" runat="server">
                    <asp:ListItem>Choose a payment method</asp:ListItem>
                    <asp:ListItem>Cash</asp:ListItem>
                    <asp:ListItem>Credit</asp:ListItem>
                    <asp:ListItem>Check</asp:ListItem>
                </asp:DropDownList>
                <asp:CompareValidator id="cvPaymentMethod"
                        runat="server" 
                        Type="String"
                        Operator="NotEqual"
                        ValueToCompare="Choose a payment method"
                        ControlToValidate="DropDownList1" 
                        Display="Dynamic"
                        ErrorMessage="Select a preferred payment method.">
                    </asp:CompareValidator>
                <asp:Label ID="Label3" runat="server" Text="Credit Card Number" class="label"></asp:Label>
                <asp:TextBox class="t" ID="txtCCNum" runat="server"></asp:TextBox>
                <asp:CustomValidator runat="server" ID="cvCreditCardNumberValidator" 
	                 ControlToValidate="txtCCNum"
	                 ErrorMessage="Invalid credit card number." CssClass="error"
	                 Display="Dynamic"
	                 ClientValidationFunction="validateCreditCardNumber" 
	                 ValidationGroup="Card" >
                </asp:CustomValidator>
                <asp:Label ID="Label4" runat="server" Text="Expiration Date" class="label"></asp:Label>
                <asp:TextBox class="t" ID="txtCCDate" runat="server"></asp:TextBox>
                <asp:CustomValidator runat="server" ID="cvExpirationDate" 
	                 ControlToValidate="txtCCDate"
	                 ErrorMessage="Invalid expiration." CssClass="error"
	                 Display="Dynamic"
	                 ClientValidationFunction="validateCreditCardExpiration">
                </asp:CustomValidator>
                <asp:Label ID="Label6" runat="server" Text="CVV" class="label"></asp:Label>
                <asp:TextBox class="t" ID="txtCVV" runat="server"></asp:TextBox>
                <asp:CustomValidator runat="server" ID="cvCCV" 
	                 ControlToValidate="txtCVV"
	                 ErrorMessage="Invalid CCV." CssClass="error"
	                 Display="Dynamic"
	                 ClientValidationFunction="validateCreditCardCCV" 
	                 ValidationGroup="Card" >
                </asp:CustomValidator>
            </div>
        </div>
        <h1 class="title">Log In Information</h1>
        <div class="container">
            <div class="grid2">
                <asp:Label ID="Label17" runat="server" Text="Create a User Name" class="label"></asp:Label>
                <asp:TextBox class="t" ID="TextBox15" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                        ControlToValidate="TextBox15"
                        Display="Dynamic"
                        ErrorMessage="Required field"
                        runat="server" />
                <asp:Label ID="Label14" runat="server" Text="Create Password" class="label"></asp:Label>
                <asp:TextBox class="t" ID="TextBox12" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2"
                        ControlToValidate="TextBox12"
                        Display="Dynamic"
                        ErrorMessage="Required field"
                        runat="server" />
                <asp:Label ID="Label15" runat="server" Text="Create Security Question" class="label"></asp:Label>
                <asp:TextBox class="t" ID="TextBox13" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3"
                        ControlToValidate="TextBox13"
                        Display="Dynamic"
                        ErrorMessage="Required field"
                        runat="server" />
                <asp:Label ID="Label16" runat="server" Text="Security Question Answer" class="label"></asp:Label>
                <asp:TextBox class="t" ID="TextBox14" runat="server" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4"
                        ControlToValidate="TextBox14"
                        Display="Dynamic"
                        ErrorMessage="Required field"
                        runat="server" />
            </div>
        </div>
        <div class="container">
                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Submit" CausesValidation="true"/>
        </div>
    </form>
</body>
</html>