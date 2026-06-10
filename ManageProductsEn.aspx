<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageProductsEn.aspx.cs" Inherits="WebApplication8.ManageProductsEn" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
    <meta charset="UTF-8">
    <title>Manage Menu Items</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background-color: #f4f6f9; font-family: 'Segoe UI', sans-serif; }
        .card { border-radius: 12px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); }
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

        <div class="container">
            <div class="row">
                <div class="col-md-4 mb-4">
                    <div class="card p-4">
                        <h4 class="fw-bold mb-3 text-primary">Add New Item</h4>
                        
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Product Name:</label>
                            <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvProdName" runat="server" ControlToValidate="txtProductName" 
                                ErrorMessage="Product name is required!" ForeColor="Red" Display="Dynamic" CssClass="small fw-bold"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revProdName" runat="server" ControlToValidate="txtProductName"
                                ValidationExpression="^[a-zA-Z\s]{3,50}$" ErrorMessage="3-50 letters only (No numbers)!" 
                                ForeColor="Red" Display="Dynamic" CssClass="small fw-bold"></asp:RegularExpressionValidator>
                        </div>

                        <div class="mb-3">
                            <label class="form-label fw-semibold">Price (EGP):</label>
                            <asp:TextBox ID="txtProductPrice" runat="server" CssClass="form-control"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvPrice" runat="server" ControlToValidate="txtProductPrice" 
                                ErrorMessage="Price is required!" ForeColor="Red" Display="Dynamic" CssClass="small fw-bold"></asp:RequiredFieldValidator>
                            <asp:RangeValidator ID="rvPrice" runat="server" ControlToValidate="txtProductPrice"
                                MinimumValue="1" MaximumValue="10000" Type="Double" 
                                ErrorMessage="Price must be between 1 and 10,000 EGP!" ForeColor="Red" Display="Dynamic" CssClass="small fw-bold"></asp:RangeValidator>
                        </div>

                        <asp:Button ID="btnSaveProduct" runat="server" OnClick="btnSaveProduct_Click" Text="➕ Add to Menu" CssClass="btn btn-primary w-100 fw-bold mt-2" />
                        <asp:Label ID="lblStatus" runat="server" CssClass="mt-2 d-block small fw-bold"></asp:Label>
                    </div>
                </div>

                <div class="col-md-8">
                    <div class="card p-4">
                        <h4 class="fw-bold mb-3 text-secondary">Current Menu Items</h4>
                        <asp:GridView ID="gvProducts" runat="server" CssClass="table table-striped table-hover align-middle m-0 text-center" AutoGenerateColumns="False">
                            <Columns>
                                <asp:BoundField DataField="ProductID" HeaderText="ID" HeaderStyle-CssClass="bg-dark text-white" />
                                <asp:BoundField DataField="ProductName" HeaderText="Item Name" ItemStyle-HorizontalAlign="Left" HeaderStyle-CssClass="bg-dark text-white" />
                                <asp:BoundField DataField="Price" HeaderText="Price (EGP)" DataFormatString="{0:N2}" HeaderStyle-CssClass="bg-dark text-white" />
                                
                                <asp:TemplateField HeaderText="Action" HeaderStyle-CssClass="bg-dark text-white">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="btnDeleteProduct" runat="server" CssClass="btn btn-sm btn-danger fw-bold" CommandArgument='<%# Eval("ProductID") %>' OnClick="btnDeleteProduct_Click" OnClientClick="return confirm('Are you sure you want to delete this item from the menu?');">❌ Delete</asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>