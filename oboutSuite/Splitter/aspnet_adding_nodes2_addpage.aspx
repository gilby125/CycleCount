<html>
	<head>
	</head>
	<body>
		<script type="text/javascript">
			function AddNode() {
			    var nodeName = document.getElementById('txtNodeName').value;
			    window.parent.AddNode(nodeName)
			}
		</script>
		<div style="font:11px verdana; color: #333333; padding-left:20px; padding-top:20px;">
			<span style="color:crimson">In this splitter panel is loaded another page.</span><br /><br />
			Add node to the treeview in left panel<br /> using button from the page loaded in the right panel.
			<br />
			<br />
			Node text: <input type='text' id='txtNodeName' value='New Node'  style="font:11px verdana;" />
			&nbsp;<input type='button' value='Add' onclick='AddNode()' style="font:11px verdana;" />
			<br /><br /><br />
		</div>
	</body>
</html>