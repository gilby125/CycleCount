imports System
imports System.Xml
imports System.Data
imports System.Data.OleDb
Imports System.Web.UI.WebControls
Imports Obout.ComboBox

public class vb_livesearch 
	inherits OboutInc.oboutAJAXPage

	protected hotelList as DataList
	protected lDestination as Literal
	protected lCheckIn as Literal
	protected lCheckOut as Literal
	protected lAdults as Literal
	protected lChildren as Literal
	protected lRooms as Literal
    Protected cboLocation As Obout.ComboBox.ComboBox
	protected myCalendar1 as OboutInc.Calendar2.Calendar 
	protected myCalendar2 as OboutInc.Calendar2.Calendar
	
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        
		if not IsPostBack
		
			PopulateWithData()
			
			myCalendar1.SelectedDate = DateTime.Now.AddDays(7)
			myCalendar1.DateMin = DateTime.Now.AddDays(7)
			myCalendar2.SelectedDate = DateTime.Now.AddDays(10)
			myCalendar2.DateMin = DateTime.Now.AddDays(7)
		
		End If
		
		if IsCallback and not Session("SearchParams") is nothing
			Search()
			Session("SearchParams") = nothing
		End If
	End Sub

	public sub PopulateWithData()
    
        ' Setting the connection
        Dim oConn as OleDbConnection = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/hotels.mdb"))
        oConn.Open()

        ' Run the query to retrieve the words that start with the give text
        Dim sQuery as string = "SELECT DISTINCT LocationID, Location FROM Location ORDER BY Location ASC"
        Dim oCommand as OleDbCommand = new OleDbCommand(sQuery)
        oCommand.Connection = oConn
        Dim oReader as OleDbDataReader = oCommand.ExecuteReader()

        ' Looping through the database records and adding them to the XML string
        while oReader.Read()
            Dim item1 As Obout.ComboBox.ComboBoxItem = New Obout.ComboBox.ComboBoxItem()
            item1.Value = oReader.GetInt32(0).ToString()
            item1.Text = oReader.GetString(1)
            cboLocation.Items.Add(item1)
        End While
        
		' Closing the connection
        oReader.Close()
        oConn.Close()
		
    End Sub
	
	' set the search params - keep in session object
	public sub SetSearchParams(byval location as string, byval locationID as string, byval checkIn as string, byval checkOut as string, byval rooms as string, byval adults as string, byval children as string)
	
		dim sp as SearchParams = new SearchParams()
		sp.location = location
		sp.locationID = locationID
		sp.checkIn = checkIn
		sp.checkOut = checkOut
		sp.rooms = rooms
		sp.adults = adults
		sp.children = children
		
		Session("SearchParams") = sp
	End Sub
	
	' search - in real life application - use all the search params to retreive the data from the database
	public sub Search()
	
		dim myConn as OleDbConnection = new OleDbConnection("Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + Server.MapPath("../App_Data/hotels.mdb"))
		myConn.Open()
		
		' get random results from the database
		if (Session("random") is nothing) 
			Session("random") = 1
		else 
			Session("random") = Int32.Parse(Session("random").ToString()) mod 5 + 1
		end if
		
		dim query as string = "SELECT name, stars, description, price, image FROM hotels where locationID = " + Session("random").ToString()
		
		dim myComm as OleDbCommand = new OleDbCommand(query, myConn)
		dim myReader as OleDbDataReader = myComm.ExecuteReader()
		
		hotelList.DataSource = myReader
		hotelList.DataBind()
		
		' populate search params details - header of the search panel
		lDestination.Text = CTYPE(Session("SearchParams"), SearchParams).location
		lCheckIn.Text = CTYPE(Session("SearchParams"), SearchParams).checkIn
		lCheckOut.Text = CTYPE(Session("SearchParams"), SearchParams).checkOut
		lAdults.Text = CTYPE(Session("SearchParams"), SearchParams).adults
		lChildren.Text = CTYPE(Session("SearchParams"), SearchParams).children
		lRooms.Text = CTYPE(Session("SearchParams"), SearchParams).rooms
	End Sub
	
	public class SearchParams
		
		private _location as string
		private _locationID as string
		private _checkIn as string
		private _checkOut as string
		private _rooms as string
		private _adults as string
		private _children as string
		
		public property location() as string
			get  
				return _location 
			end get
			set(byval value as string)  
				_location = value
			end set
		end property
		
		public property locationID() as string
			get  
				return _locationID 
			end get
			set(byval value as string)  
				_locationID = value
			end set
		end property
		
		public property checkIn() as string
			get  
				return _checkIn 
			end get
			set(byval value as string)  
				_checkIn = value
			end set
		end property
		
		public property checkOut() as string
			get  
				return _checkOut 
			end get
			set(byval value as string)  
				_checkOut = value
			end set
		end property
		
		public property rooms() as string
			get  
				return _rooms 
			end get
			set(byval value as string)  
				_rooms = value
			end set
		end property
		
		public property adults() as string
			get  
				return _adults 
			end get
			set(byval value as string)  
				_adults = value
			end set
		end property
		
		public property children() as string
			get  
				return _children 
			end get
			set(byval value as string)  
				_children = value
			end set
		end property		

	End Class	
End Class