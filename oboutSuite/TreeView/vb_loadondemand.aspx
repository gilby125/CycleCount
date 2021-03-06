<%@ Page Language="VB" %>

<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Example Page - LoadOnDemand Support</title>
     <style type="text/css">
        body
        {
            font-family: "Segoe UI" ,Arial,sans-serif;
            font-size: 12px;
        }
    </style>

    <script language="VB" runat="server">
        Private ObTree As Tree = Nothing
        Private Sub Page_Init(ByVal sender As Object, ByVal e As EventArgs)

            ObTree = New Tree() With {.ID = "ObClassicTree", .DataSourceID = "XmlDataSource1", .EnableViewState = False, .LoadingMessage = "Loading...", .CssClass = "vista", .Width = 200}

            ObTree.DataBindings.Add(New NodeBinding() With {.DataMember = "employee", .ExpandMode = NodeExpandMode.ServerSideCallback, .TextField = "name", .ImageUrl = "img/engineer-icon.png"})

            Me.TreePlaceHolder.Controls.Add(ObTree)

        End Sub
        Private Sub Page_load(ByVal sender As Object, ByVal e As EventArgs)
            If IsPostBack Then
                ObTree.DataBind()
            End If
        End Sub
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <br />
		<a class="examples" href="Default.aspx?type=ASPNET">� Back to examples</a>
		<br />
    <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />

    <script type="text/javascript">
        function onCheckChange(obj) {
            obTreeClientObj.loadingMessage = obj.checked ? 'Refreshing...' : 'Loading...';
        }
    </script>

    <div>
        <h2>
            ASP.NET TreeView - LoadOnDemand Support</h2>
        <div class="live_example">
        </div>
        <asp:XmlDataSource ID="XmlDataSource1" DataFile="employee.xml" runat="server"></asp:XmlDataSource>
        <p>
            To enable 'LoadOndemand' feature for a node, the node property, '<b>ExpandMode</b>'
            should be set as '<b>ServerSideCallback</b>'</p>
        <table>
            <tr>
                <td>
                    <asp:PlaceHolder ID="TreePlaceHolder" runat="server"></asp:PlaceHolder>
                </td>
                <td valign="top">
                    <input id="Checkbox1" onchange="onCheckChange(this)" type="checkbox" />
                    Change loading message as 'Refreshing'
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
