using System;
using System.Data.OleDb;
using Obout.Ajax.UI.TreeView;

public partial class cs_addressbook : System.Web.UI.Page
{
	void Page_Load(object sender, EventArgs e) {
        if (!Page.IsPostBack)
        {
            OleDbConnection oConn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/AddressBook.mdb"));
            oConn.Open();

            Node rootNode = new Node() { Text = "Address Book", Expanded = true, Selected=true, ImageUrl = "../TreeView/icons/folder.gif" };
            ObTree.Nodes.Add(rootNode);
            string sQuery = "SELECT DepartmentID, DepartmentName FROM Departments ORDER BY DepartmentName ASC";
            OleDbCommand oCommand = new OleDbCommand(sQuery);
            oCommand.Connection = oConn;
            OleDbDataReader oReader = oCommand.ExecuteReader();

            string sDepartmentID, sDepartmentName;


            while (oReader.Read())
            {
                sDepartmentID = oReader.GetInt32(0).ToString();
                sDepartmentName = oReader.GetValue(1).ToString();

                rootNode.ChildNodes.Add(new Node() { Text = sDepartmentName, Value = "DEPART" + sDepartmentID, Expanded = true, ImageUrl = "../TreeView/icons/oInboxF.gif" });
            }
            oConn.Close();
            oConn.Open();

            sQuery = "SELECT ContactID, FirstName, LastName, DepartmentID FROM Contacts ORDER BY FirstName ASC, LastName ASC";
            oCommand = new OleDbCommand(sQuery);
            oCommand.Connection = oConn;
            OleDbDataReader oReader2 = oCommand.ExecuteReader();

            string sContactId, sFirstName, sLastName;

            while (oReader2.Read())
            {
                sContactId = oReader2.GetInt32(0).ToString();
                sFirstName = oReader2.GetValue(1).ToString();
                sLastName = oReader2.GetValue(2).ToString();
                sDepartmentID = oReader2.GetInt32(3).ToString();
                Node parent = rootNode.ChildNodes.FindNode(c => c.Value == "DEPART" + sDepartmentID, false);
                if (parent != null)
                {
                    parent.ChildNodes.Add(new Node() { Value = sContactId, Text = string.Format("{0} {1}", sFirstName, sLastName), ImageUrl = "../TreeView/icons/person.gif" });
                }
            }
            oConn.Close();
        }
    }

    protected void NodeSelected(object sender, NodeEventArgs e)
    {
        if (e.Node.Value.IndexOf("DEPART") < 0)
        {
            SetContactInformation(e.Node.Value);
            PersonalInfoPanel.Visible = true;
        }
        else
        {
            PersonalInfoPanel.Visible = false;
        }
        PersonalInfo.Update();
    }
	
	public void SetContactInformation(string strID)
	{
        int id = Int32.Parse(strID);

		OleDbConnection oConn = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/addressbook.mdb"));
		oConn.Open();

		string sQuery = "SELECT FirstName, LastName, CompanyName, Email, Phone, CellPhone, Fax, Picture FROM Contacts WHERE ContactID = " + id.ToString();
		OleDbCommand oCommand = new OleDbCommand(sQuery);
		oCommand.Connection = oConn;
		OleDbDataReader oReader = oCommand.ExecuteReader();

		oReader.Read();
		
		string sFirstName;
		string sLastName;
		string sCompanyName;
		string sEmail;
		string sPhone;
		string sCellPhone;
		string sFax;
		string sPicture;
		
		sFirstName = oReader.GetString(0);
		sLastName = oReader.GetString(1);
		sCompanyName = oReader.GetString(2);
		sEmail = oReader.GetString(3);
		sPhone = oReader.GetString(4);
		sCellPhone = oReader.GetString(5);
		sFax = oReader.GetString(6);
		sPicture = oReader.GetString(7);

        lContactImage.Text = "<img style=\"width:70px\" src=\"images/" + sPicture + "\" />";
		lContactName.Text = sFirstName + " " + sLastName;
		lContactCompany.Text = sCompanyName;
		lContactEmail.Text = sEmail;
		lContactPhone.Text = sPhone;
		lContactCell.Text = sCellPhone;
		lContactFax.Text = sFax;
		
		oConn.Close();
	}
}