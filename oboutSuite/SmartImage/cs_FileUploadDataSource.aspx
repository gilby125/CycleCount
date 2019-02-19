<%@ Page Language="C#" AutoEventWireup="true" CodeFile="cs_FileUploadDataSource.aspx.cs" Inherits="SmartImage_cs_FileUploadDataSource" %>
<%@ Register Assembly="Obout.Ajax.UI" TagPrefix="obout" Namespace="Obout.Ajax.UI.FileUpload" %>
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
    <span class="tdText"><b>Obout.Ajax.UI.SmartImage</b> - With the obout <b>FileUpload</b> as data source</span>
    <br /><br />
    <a href="Default.aspx?type=CSHARP">< Back to examples</a>
    <br /><br />
    <form id="form1" runat="server" enctype="multipart/form-data" method="post">
        <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />
        Upload images and you will see information about them.
        <br /><br />
        <asp:UpdatePanel runat="server" ID="UpdatePanel1"><ContentTemplate>
            <obout:FileUpload Accept="image/*" ValidFileExtensions="jpeg;jpg;gif;tiff;png"
                Width="250px" runat="server" id="fileUpload1" BrowseFieldDescription="Images"
            />
            <br /><asp:Button runat="server" ID="submit" Text="Upload files" /><br /><br />

            <asp:ListView ID="lvMain" runat="server" DataSourceID="fileUpload1"
                            GroupItemCount="3" EnableViewState="false"
                            GroupPlaceholderID="ContactRowContainer"
                            ItemPlaceholderID="ContactItemContainer">
                <LayoutTemplate>
                    <table cellpadding="4" runat="server" id="tblContacts">
                    <tr runat="server">
                        <th colspan="3" runat="server"><b>Uploaded images</b></th>
                    </tr>
                    <tr runat="server" id="ContactRowContainer" />
                    </table>
                </LayoutTemplate>
                <GroupTemplate>
                    <tr runat="server" id="ContactRow">
                    <td runat="server" id="ContactItemContainer" />
                    </tr>
                </GroupTemplate>
                <EmptyItemTemplate>
                    <td class="item" runat="server">
                    </td>
                </EmptyItemTemplate>
                <ItemTemplate>
                    <td class="item" runat="server" style="border: 1px solid black;" align="left">
                        <obout:SmartImage ID="smImage" runat="server" BinaryValue='<%# Eval("ContentBinary") %>' Height="100px" GetImageMode="HttpHandler" ImageAlign="Right" OptimizeMode="Fit" />
                        <table cellpadding="3" style="font-family: Tahoma; font-size: 11px; ">
                            <tr>
                                <td align="left" valign="middle" >
                                    <b>File name</b>
                                </td>
                                <td align="left" valign="middle" >
                                    <%# Eval("FileName") %>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" valign="middle" >
                                    <b>Content type</b>
                                </td>
                                <td align="left" valign="middle" >
                                    <%# Eval("ContentType") %>
                                </td>
                            </tr>
                            <tr>
                                <td align="left" valign="middle" >
                                    <b>Content length</b>
                                </td>
                                <td align="left" valign="middle" >
                                    <%# Eval("ContentLength").ToString() %>
                                </td>
                            </tr>
                        </table>
                    </td>
                </ItemTemplate>
            </asp:ListView>

        </ContentTemplate></asp:UpdatePanel>
    </form>
</body>
</html>
