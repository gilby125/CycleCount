Imports System.Data.OleDb
Imports Obout.Ajax.UI.TreeView

Partial Public Class vb_addressbook
    Inherits System.Web.UI.Page
    Private Sub Page_Load(sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            Dim oConn As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("../App_Data/AddressBook.mdb"))
            oConn.Open()

            Dim rootNode As New Node() With { _
             .Text = "Address Book", _
             .Expanded = True, _
             .Selected = True, _
             .ImageUrl = "../TreeView/icons/folder.gif" _
            }
            ObTree.Nodes.Add(rootNode)
            Dim sQuery As String = "SELECT DepartmentID, DepartmentName FROM Departments ORDER BY DepartmentName ASC"
            Dim oCommand As New OleDbCommand(sQuery)
            oCommand.Connection = oConn
            Dim oReader As OleDbDataReader = oCommand.ExecuteReader()

            Dim sDepartmentID As String, sDepartmentName As String


            While oReader.Read()
                sDepartmentID = oReader.GetInt32(0).ToString()
                sDepartmentName = oReader.GetValue(1).ToString()

                rootNode.ChildNodes.Add(New Node() With { _
                 .Text = sDepartmentName, _
                 .Value = "DEPART" & sDepartmentID, _
                 .Expanded = True, _
                 .ImageUrl = "../TreeView/icons/oInboxF.gif" _
                })
            End While
            oConn.Close()
            oConn.Open()

            sQuery = "SELECT ContactID, FirstName, LastName, DepartmentID FROM Contacts ORDER BY FirstName ASC, LastName ASC"
            oCommand = New OleDbCommand(sQuery)
            oCommand.Connection = oConn
            Dim oReader2 As OleDbDataReader = oCommand.ExecuteReader()

            Dim sContactId As String, sFirstName As String, sLastName As String

            While oReader2.Read()
                sContactId = oReader2.GetInt32(0).ToString()
                sFirstName = oReader2.GetValue(1).ToString()
                sLastName = oReader2.GetValue(2).ToString()
                sDepartmentID = oReader2.GetInt32(3).ToString()
                Dim parent As Node = rootNode.ChildNodes.FindNode(Function(c) c.Value = "DEPART" & sDepartmentID, False)
                If parent IsNot Nothing Then
                    parent.ChildNodes.Add(New Node() With { _
                     .Value = sContactId, _
                     .Text = String.Format("{0} {1}", sFirstName, sLastName), _
                     .ImageUrl = "../TreeView/icons/person.gif" _
                    })
                End If
            End While
            oConn.Close()
        End If
    End Sub

    Protected Sub NodeSelected(sender As Object, e As NodeEventArgs)
        If e.Node.Value.IndexOf("DEPART") < 0 Then
            SetContactInformation(e.Node.Value)
            PersonalInfoPanel.Visible = True
        Else
            PersonalInfoPanel.Visible = False
        End If
        PersonalInfo.Update()
    End Sub

    Public Sub SetContactInformation(strID As String)
        Dim id As Integer = Int32.Parse(strID)

        Dim oConn As New OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath("../App_Data/addressbook.mdb"))
        oConn.Open()

        Dim sQuery As String = "SELECT FirstName, LastName, CompanyName, Email, Phone, CellPhone, Fax, Picture FROM Contacts WHERE ContactID = " & id.ToString()
        Dim oCommand As New OleDbCommand(sQuery)
        oCommand.Connection = oConn
        Dim oReader As OleDbDataReader = oCommand.ExecuteReader()

        oReader.Read()

        Dim sFirstName As String
        Dim sLastName As String
        Dim sCompanyName As String
        Dim sEmail As String
        Dim sPhone As String
        Dim sCellPhone As String
        Dim sFax As String
        Dim sPicture As String

        sFirstName = oReader.GetString(0)
        sLastName = oReader.GetString(1)
        sCompanyName = oReader.GetString(2)
        sEmail = oReader.GetString(3)
        sPhone = oReader.GetString(4)
        sCellPhone = oReader.GetString(5)
        sFax = oReader.GetString(6)
        sPicture = oReader.GetString(7)

        lContactImage.Text = "<img style=""width:70px"" src=""images/" & sPicture & """ />"
        lContactName.Text = sFirstName & " " & sLastName
        lContactCompany.Text = sCompanyName
        lContactEmail.Text = sEmail
        lContactPhone.Text = sPhone
        lContactCell.Text = sCellPhone
        lContactFax.Text = sFax

        oConn.Close()
    End Sub
End Class
