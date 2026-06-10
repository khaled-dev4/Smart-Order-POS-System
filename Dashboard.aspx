<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="WebApplication8.Dashboard" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <title>Sales Analytics Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', sans-serif; }
        .card-stat { border-radius: 12px; border: none; box-shadow: 0 4px 12px rgba(0,0,0,0.05); color: white; }
        .card-table { border-radius: 12px; box-shadow: 0 4px 12px rgba(0,0,0,0.05); background: white; }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- شريط التنقل العلوي الموحد المطور -->
        <nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 px-4">
            <a class="navbar-brand fw-bold" href="#">🍽️ Smart Order</a>
            <div class="navbar-nav ms-auto gap-2 align-items-center">
                <a href="CreateOrder.aspx" class="btn btn-primary fw-bold">🛍️ Create New Order</a>
                <a href="ManageProductsEn.aspx" class="btn btn-success">📋 Manage Menu</a>
                <a href="Dashboard.aspx" class="btn btn-warning fw-bold text-dark">📊 Sales Dashboard</a> <asp:LinkButton ID="LinkButton1" runat="server" OnClick="btnLogout_Click" CausesValidation="false" CssClass="btn btn-danger fw-bold ms-3">🚪 Logout</asp:LinkButton>
            </div>
        </nav>

        <div class="container">
            <h3 class="fw-bold text-dark mb-4">📈 Sales Analytics & Reports</h3>

            <div class="card p-4 card-table mb-4">
                <h5 class="fw-bold text-secondary mb-3">Filter by Date Range</h5>
                <div class="row align-items-end">
                    <div class="col-md-4 mb-3 mb-md-0">
                        <label class="form-label fw-semibold">From Date:</label>
                        <asp:TextBox ID="txtFromDate" runat="server" CssClass="form-control" Type="Date"></asp:TextBox>
                    </div>
                    <div class="col-md-4 mb-3 mb-md-0">
                        <label class="form-label fw-semibold">To Date:</label>
                        <asp:TextBox ID="txtToDate" runat="server" CssClass="form-control" Type="Date"></asp:TextBox>
                    </div>
                    <div class="col-md-4 d-grid">
                        <asp:Button ID="btnFilter" runat="server" Text="🔍 Generate Report" CssClass="btn btn-dark fw-bold py-2" OnClick="btnFilter_Click" />
                    </div>
                </div>
            </div>

            <div class="row mb-4">
                <div class="col-md-6 mb-3 mb-md-0">
                    <div class="card p-4 card-stat bg-success">
                        <small class="text-uppercase fw-bold opacity-75">Total Revenue (EGP)</small>
                        <h2 class="fw-bold m-0 mt-1"><asp:Label ID="lblTotalRevenue" runat="server" Text="0.00"></asp:Label></h2>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="card p-4 card-stat bg-primary">
                        <small class="text-uppercase fw-bold opacity-75">Total Orders Placed</small>
                        <h2 class="fw-bold m-0 mt-1"><asp:Label ID="lblTotalOrders" runat="server" Text="0"></asp:Label></h2>
                    </div>
                </div>
            </div>

            <div class="card p-4 card-table">
                <h5 class="fw-bold text-secondary mb-3">Order Records History</h5>
                <div class="table-responsive">
                    <asp:GridView ID="gvSalesHistory" runat="server" CssClass="table table-striped table-hover align-middle text-center m-0" AutoGenerateColumns="False">
                        <Columns>
                            <asp:BoundField DataField="OrderID" HeaderText="Order ID" HeaderStyle-CssClass="bg-dark text-white" />
                            <asp:BoundField DataField="OrderDate" HeaderText="Date & Time" DataFormatString="{0:yyyy-MM-dd HH:mm}" HeaderStyle-CssClass="bg-dark text-white" />
                            <asp:BoundField DataField="TableNumber" HeaderText="Table No." HeaderStyle-CssClass="bg-dark text-white" />
                            <asp:BoundField DataField="TotalAmount" HeaderText="Amount Paid (EGP)" DataFormatString="{0:N2}" HeaderStyle-CssClass="bg-dark text-white" />
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
