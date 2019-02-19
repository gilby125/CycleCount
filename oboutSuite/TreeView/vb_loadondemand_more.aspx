<%@ Page Language="VB" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    Private Tree1 As Tree = Nothing
    Private Sub Page_Init(ByVal sender As Object, ByVal e As EventArgs)

        Tree1 = New Tree() With {.ID = "Tree1", .Width = 200, .OnNodeExpand="expanding"}
        AddHandler Tree1.TreeNodeExpanded, AddressOf Tree1_TreeNodeExpanded
        Me.TreePlaceHolder.Controls.Add(Tree1)

    End Sub
    
    Private Sub Page_load(ByVal sender As Object, ByVal e As EventArgs)
        If Not Page.IsPostBack Then
            Dim firstnode As New Node
            firstnode.Text = "Root"
            firstnode.ClientID = "0"
            firstnode.Value = "Fld_0"
            Tree1.Nodes.Add(firstnode)
            fillmore(Nothing, firstnode, 0)
        End If
    End Sub
    
    Protected Sub Tree1_TreeNodeExpanded(ByVal sender As Object, ByVal e As Obout.Ajax.UI.TreeView.NodeEventArgs)

        If e.Node.ClientID.IndexOf("more_node") = 0 Then
            Dim partNumber As Integer = Integer.Parse(e.Node.ClientID.Split(New Char() {"-"c})(1))
            fillmore(e.Node, e.Node.Parent, partNumber)
        End If
    End Sub
    
    Public Sub fillmore(ByVal currentTreeNode As Obout.Ajax.UI.TreeView.Node, ByVal parentTreeNode As Obout.Ajax.UI.TreeView.Node, ByVal partNumber As Integer)

        If Not currentTreeNode Is Nothing Then
            parentTreeNode.ChildNodes.Remove(currentTreeNode)
        End If
        parentTreeNode.Expanded = True
        Dim i As Integer = partNumber * 10 + 1
        While i <= (partNumber + 1) * 10
            Dim node As New Node
            node.Text = i.ToString()
            node.ClientID = i.ToString()
            node.Value = "Fld_" & i.ToString()
            node.ExpandMode = NodeExpandMode.ClientSide
            parentTreeNode.ChildNodes.Add(node)
            i = i + 1
        End While
        Dim more_node As New Node
        more_node.Text = "<b>More...</b>"
        more_node.ClientID = "more_node-" & (partNumber + 1).ToString()
        more_node.Value = "Fld_more_node-" & (partNumber + 1).ToString()
        more_node.ExpandMode = NodeExpandMode.ServerSide
        more_node.SelectMode = NodeSelectMode.Expand
        more_node.Expanded = True
        parentTreeNode.ChildNodes.Add(more_node)
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" >
        function expanding(sender, args) {
            var node = args.node;
            var txtCont = sender._getNodeTextContainer(node);
            //prevent from multiple node expand during postback
            if (txtCont.style.display == "none") {
                return;
            }
            var loadingElement = sender.getLoadingEle(txtCont.className);
            txtCont.style.display = "none";
            node.appendChild(loadingElement);
        }
    </script>   
</head>
<body>
    <form id="form1" runat="server">
    <br />
		<a class="examples" href="Default.aspx?type=VBNET">« Back to examples</a>
		<br />
    <asp:ScriptManager runat="Server" EnablePartialRendering="true" ID="ScriptManager1" />

    <div>
        <h2>
            ASP.NET TreeView - LoadOnDemand Support</h2>
        <div class="live_example">
        </div>
        <asp:XmlDataSource ID="XmlDataSource1" DataFile="employee.xml" runat="server"></asp:XmlDataSource>
        <p>
            Nodes are added to the root on demand, just click <b>'More...'</b>.
        </p>
        <asp:UpdatePanel runat="server"><ContentTemplate>
            <asp:PlaceHolder ID="TreePlaceHolder" runat="server"></asp:PlaceHolder>
       </ContentTemplate></asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
