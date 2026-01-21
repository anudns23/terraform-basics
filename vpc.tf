resource "aws_vpc" "DemoBasicVPc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    "Name" = var.vpc_name

  }

}



# IGW
resource "aws_internet_gateway" "DemoBAsicIGW" {
  vpc_id = aws_vpc.DemoBasicVPc.id
  tags = {
    "Name" = "${var.vpc_name}-igw"
  }
}

# Subnet
resource "aws_subnet" "DemoBasicSubnet-1" {
  vpc_id     = aws_vpc.DemoBasicVPc.id
  cidr_block = var.subnet1_cidr
  tags = {
    "Name" = var.subnet1_name
  }
}

resource "aws_subnet" "DemoBasicSubnet-2" {
  vpc_id     = aws_vpc.DemoBasicVPc.id
  cidr_block = var.subnet2_cidr
  tags = {
    "Name" = var.subnet2_name
  }
}


# Route Table
resource "aws_route_table" "DemoBasicRouteTable" {
  vpc_id = aws_vpc.DemoBasicVPc.id
  tags = {
    "Name" = "${var.vpc_name}-route-table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.DemoBAsicIGW.id
  }

}

# Subnet association to route table
resource "aws_route_table_association" "Demo_Basic_Route1_Association" {

  subnet_id      = aws_subnet.DemoBasicSubnet-1.id
  route_table_id = aws_route_table.DemoBasicRouteTable.id
}

resource "aws_route_table_association" "Demo_Basic_Route2_Association" {

  subnet_id      = aws_subnet.DemoBasicSubnet-2.id
  route_table_id = aws_route_table.DemoBasicRouteTable.id
}