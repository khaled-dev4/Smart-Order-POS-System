<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CreateOrder.aspx.cs" Inherits="WebApplication8.CreateOrder" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <title>Create New Order</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', sans-serif; }
        .card { border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); }
        .btn-action { padding: 2px 8px; font-size: 0.9rem; font-weight: bold; }
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
                <a href="Dashboard.aspx" class="btn btn-warning fw-bold text-dark">📊 Sales Dashboard</a>
                <asp:LinkButton ID="LinkButton1" runat="server" OnClick="btnLogout_Click" CausesValidation="false" CssClass="btn btn-danger fw-bold ms-3">🚪 Logout</asp:LinkButton>
                
            </div>
        </nav>

        <div class="container-fluid px-4">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card p-4 mb-3">
                        <h4 class="fw-bold mb-3 text-primary">Select Item</h4>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Menu Products:</label>
                            <asp:DropDownList ID="ddlProducts" runat="server" CssClass="form-select"></asp:DropDownList>
                        </div>
                        <div class="d-grid mt-4">
                            <asp:Button ID="btnAddToGrid" runat="server" Text="Add Item to Order" CssClass="btn btn-primary py-2 fw-bold" OnClick="btnAddToCart_Click" />
                        </div>
                    </div>
                </div>

                <div class="col-md-8">
                    <div class="card p-4">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="fw-bold m-0 text-secondary">Current Order Items 🛒</h4>
                            <span class="badge bg-danger fs-6 p-2">Live Basket</span>
                        </div>
                        
                        <div class="table-responsive">
                            <asp:GridView ID="gvCart" runat="server" CssClass="table table-striped table-hover align-middle text-center m-0" AutoGenerateColumns="False">
                                <Columns>
                                    <asp:BoundField DataField="ProductID" HeaderText="ID" HeaderStyle-CssClass="bg-dark text-white" />
                                    <asp:BoundField DataField="ProductName" HeaderText="Item" ItemStyle-HorizontalAlign="Left" HeaderStyle-CssClass="bg-dark text-white" />
                                    <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:N2}" HeaderStyle-CssClass="bg-dark text-white" />
                                    
                                    <asp:TemplateField HeaderText="Quantity" HeaderStyle-CssClass="bg-dark text-white">
                                        <ItemTemplate>
                                            <div class="d-flex justify-content-center align-items-center gap-2">
                                                <asp:LinkButton ID="btnDecrease" runat="server" CssClass="btn btn-sm btn-outline-secondary btn-action" CommandArgument='<%# Eval("ProductID") %>' OnClick="btnDecrease_Click"> - </asp:LinkButton>
                                                <span class="fw-bold mx-1"><%# Eval("Quantity") %></span>
                                                <asp:LinkButton ID="btnIncrease" runat="server" CssClass="btn btn-sm btn-outline-secondary btn-action" CommandArgument='<%# Eval("ProductID") %>' OnClick="btnIncrease_Click"> + </asp:LinkButton>
                                            </div>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:BoundField DataField="Total" HeaderText="Total" DataFormatString="{0:N2}" HeaderStyle-CssClass="bg-dark text-white" />
                                    
                                    <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="bg-dark text-white">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnRemove" runat="server" CssClass="btn btn-sm btn-danger fw-bold" CommandArgument='<%# Eval("ProductID") %>' OnClick="btnRemove_Click">❌ Delete</asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>

                        <div class="d-flex justify-content-between align-items-center mt-4 pt-3 border-top">
                            <div class="fs-4 fw-bold text-dark">
                                Total Amount: <span class="text-success"><asp:Label ID="lblTotalCart" runat="server" Text="0.00"></asp:Label> EGP</span>
                            </div>
                            <asp:Button ID="btnConfirmOrder" runat="server" Text="🧾 Confirm & Print Order" CssClass="btn btn-success btn-lg fw-bold px-4" OnClick="btnConfirmOrder_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
