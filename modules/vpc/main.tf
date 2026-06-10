# -- VPC
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name    = "${var.app}-${var.env}-vpc"
    app     = var.app
    managed = "terraform"
  }
}

# -- Internet Gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name    = "${var.app}-${var.env}-igw"
    app     = var.app
    managed = "terraform"
  }
}

# -- Public Subnets
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name    = "${var.app}-${var.env}-public-subnet-${count.index + 1}"
    app     = var.app
    managed = "terraform"
  }
}

# -- Private Subnets
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.this.id
  cidr_block        = var.private_subnet_cidrs[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name    = "${var.app}-${var.env}-private-subnet-${count.index + 1}"
    app     = var.app
    managed = "terraform"
  }
}

# -- NAT Gateway EIP
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name    = "${var.app}-${var.env}-nat-eip"
    app     = var.app
    managed = "terraform"
  }
}

# -- NAT Gateway (Public Subnet 배치)
resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name    = "${var.app}-${var.env}-nat"
    app     = var.app
    managed = "terraform"
  }

  depends_on = [aws_internet_gateway.this]
}

# -- Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name    = "${var.app}-${var.env}-public-rt"
    app     = var.app
    managed = "terraform"
  }
}

resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# -- Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name    = "${var.app}-${var.env}-private-rt"
    app     = var.app
    managed = "terraform"
  }
}

resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}
