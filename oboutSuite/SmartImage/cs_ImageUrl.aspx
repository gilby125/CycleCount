<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cs_ImageUrl.aspx.cs" Inherits="SmartImage_cs_ImageUrl" %>
<%@ Register Assembly="Obout.Ajax.UI" TagPrefix="obout" Namespace="Obout.Ajax.UI.SmartImage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>SmartImage example</title>
    <style type="text/css">
            a {
                   font-size:10pt;font-family:Tahoma
            }
            a:hover {
                   color:crimson;
            }
            .tdText {
                    font:11px Verdana;
                    color:#333333;
            }
            .listview-item 
            {
                display:inline inline-block;
            }
    </style>
</head>
<body>
    <span class="tdText"><b>Obout.Ajax.UI.SmartImage</b> - With Image URL</span>
    <br /><br />
    <a href="Default.aspx?type=CSHARP">< Back to examples</a>
    <br /><br />
    <form id="form1" runat="server" enctype="multipart/form-data" method="post">
        <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
        Images from the site:
        <br /><br />
        <obout:SmartImage runat="server" ImageUrl="~/ImageZoom/images/IMG_2464.jpg" Width="300px" OptimizeMode="Fit" />&nbsp;
        <obout:SmartImage runat="server" ImageUrl="~/ImageZoom/images/IMG_2473.jpg" Width="300px" OptimizeMode="Fit" />
    </form>
</body>
</html>
