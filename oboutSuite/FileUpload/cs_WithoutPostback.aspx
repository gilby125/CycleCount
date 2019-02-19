<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cs_WithoutPostback.aspx.cs" Inherits="FileUpload_cs_WithoutPostback" %>
<%@ Register
    Assembly="Obout.Ajax.UI"
    Namespace="Obout.Ajax.UI.FileUpload"
    TagPrefix="obout" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>FileUpload example</title>
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
    </style>
</head>
<body>
    <script type="text/JavaScript">
        // clear result holder
        function clearResult() {
            $get("<%= label.ClientID %>").innerHTML = "";
            return true;
        }
        // send files
        function send() {
            // get the FileUpload component
            var uploader = $find("<%= fileUpload1.ClientID %>");
            // send selected files
            uploader.send();
            return false;
        }
        // executed on server response (files uploaded)
        function onServerPesponse(sender, args) {
            // for a new sending
            setTimeout(function () { sender.set_isFinished(false); }, 0);
            // clear selected files
            sender._filesList.clear(true);
            // enable inner picker
            sender._innerPicker.enable();
            // clear the progress bar
            setTimeout(function () { sender.get_progressbar().set_value(""); }, 0);
            // save uploaded files
            setTimeout(saveUploadedFiles,0);
        }
        // save uploaded files using callback
        function saveUploadedFiles() {
            var action = "saveUploadedFiles";
            var context = "";
            // execute callback
            <%=sCallBackFunctionInvocation%>
        }
        // callback result processing
        function processMyResult(returnmessage, context){
             $get("<%= label.ClientID %>").innerHTML = returnmessage;
        }
        // callback error processing
        function processMyError(returnmessage, context){
            alert("Callback Error: " + returnmessage);
        }
    </script>
    <span class="tdText"><b>Obout.Ajax.UI.FileUpload</b> - Upload and save files without Postback</span>
    <br /><br />
    <a href="Default.aspx?type=CSHARP">< Back to examples</a>
    <br /><br />
    <form id="form1" runat="server" enctype="multipart/form-data" method="post">
        <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
        <center>
            Here you can upload and save up to 10 MB of images <i>without any postback</i> (Callback is used).
            <br /><br />
                <obout:FileUpload  OnClientBeforeUpload="clearResult"
                    OnClientAfterServerResponse="onServerPesponse" Accept="image/*"
                    ValidFileExtensions="jpeg;jpg;gif;tiff;png" MaximumTotalFileSize="10240"
                    Width="250px" runat="server" id="fileUpload1" BrowseFieldDescription="Images"
                />
                <br />
                <asp:Button runat="server" ID="upload" Text="Upload and save files" OnClientClick="return send();" />
                <br /><br />
                <asp:Label runat="server" ID="label" Text="" />
        </center>
    </form>
</body>
</html>
