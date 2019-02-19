<%@ Page Language="C#" %>
<%@ Register Assembly="Obout.Ajax.UI" Namespace="Obout.Ajax.UI.TreeView" TagPrefix="obout" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    private Tree Tree1 = null;

    private void Page_Init(object sender, EventArgs e)
    {
        Tree1 = new Tree
        {
            ID = "Tree1",
            Width = 200,
            OnNodeExpand = "expanding"
        };
        Tree1.TreeNodeExpanded += Tree1_TreeNodeExpanded;
        this.TreePlaceHolder.Controls.Add(Tree1);

    }

    private void Page_load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            Node firstnode = new Node();
            firstnode.Text = "Root";
            firstnode.ClientID = "0";
            firstnode.Value = "Fld_0";
            Tree1.Nodes.Add(firstnode);
            fillmore(null, firstnode, 0);
        }
    }
    
    protected void Tree1_TreeNodeExpanded(object sender, Obout.Ajax.UI.TreeView.NodeEventArgs e)
    {
        if (e.Node.ClientID.IndexOf("more_node") == 0)
        {
            int partNumber = int.Parse(e.Node.ClientID.Split(new char[] { '-' })[1]);
            fillmore(e.Node, e.Node.Parent, partNumber);
        }
    }
    
    public void fillmore(Obout.Ajax.UI.TreeView.Node currentTreeNode, Obout.Ajax.UI.TreeView.Node parentTreeNode, int partNumber)
    {
        if ((currentTreeNode != null))
        {
            parentTreeNode.ChildNodes.Remove(currentTreeNode);
        }
        parentTreeNode.Expanded = true;
        int i = partNumber * 10 + 1;
        while (i <= (partNumber + 1) * 10)
        {
            Node node = new Node();
            node.Text = i.ToString();
            node.ClientID = i.ToString();
            node.Value = "Fld_" + i.ToString();
            node.ExpandMode = NodeExpandMode.ClientSide;
            parentTreeNode.ChildNodes.Add(node);
            i = i + 1;
        }
        Node more_node = new Node();
        more_node.Text = "<b>More...</b>";
        more_node.ClientID = "more_node-" + (partNumber + 1).ToString();
        more_node.Value = "Fld_more_node-" + (partNumber + 1).ToString();
        more_node.ExpandMode = NodeExpandMode.ServerSide;
        more_node.SelectMode = NodeSelectMode.Expand;
        more_node.Expanded = true;
        parentTreeNode.ChildNodes.Add(more_node);
    }
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
		<a class="examples" href="Default.aspx?type=CSHARP">« Back to examples</a>
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
