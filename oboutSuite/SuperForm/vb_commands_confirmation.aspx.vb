﻿Imports Obout.SuperForm
Imports System.Data
Imports System.Data.OleDb
Imports System.Collections.Generic
Imports System.Web.UI.WebControls
Partial Class SuperForm_vb_commands_confirmation
    Inherits System.Web.UI.Page
    Dim SuperForm1 As Obout.SuperForm.SuperForm

    Sub Page_load(ByVal sender As Object, ByVal e As EventArgs)
        SuperForm1 = New SuperForm()
        SuperForm1.ID = "SuperForm1"
        SuperForm1.Title = "Order Details"
        SuperForm1.DataSourceID = "SqlDataSource1"
        SuperForm1.AutoGenerateInsertButton = True
        SuperForm1.AutoGenerateEditButton = True
        SuperForm1.AutoGenerateDeleteButton = True
        SuperForm1.AutoGenerateDateFields = True
        Dim keyNames() As String = {"Order ID"}
        SuperForm1.AllowPaging = True
        SuperForm1.DefaultMode = DetailsViewMode.Edit

        SuperForm1.ClientSideEvents.OnDeleting = "SuperForm1_Deleting"
        SuperForm1.ClientSideEvents.OnInserting = "SuperForm1_Inserting"
        SuperForm1.ClientSideEvents.OnUpdating = "SuperForm1_Updating"

        SuperForm1Container.Controls.Add(SuperForm1)

    End Sub
End Class
