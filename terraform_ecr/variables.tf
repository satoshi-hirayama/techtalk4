# 環境の変数設定

# AWSのアクセスキー
# アクセスキー自体はterraform.tfvarsに書く（Gitの管理対象外）
variable "aws_id" {
  description = "AWS ID"
}

variable "aws_access_key" {
  description = "AWS access key"
}

variable "aws_secret_key" {
  description = "AWS secret access key"
}

# VPCを配備するリージョン
variable "region" {
  default = "ap-northeast-1"
}

# インスタンス等のデフォルト名称（必要に応じて _app や _worker などが追加されます）
variable "base_name" {
  default = "techtalk"
}

# インスタンス等のデフォルト名称（アンダースコアが使えないサービスではハイフンにする）
variable "base_name_hyphen" {
  default = "techtalk"
}

# インスタンス等のデフォルト名称（アルファベットか数値のみのサービスではキャメルケースにする）
variable "base_name_camel" {
  default = "Techtalk"
}

# VPCのCIDR
variable "vpc_cidr_block" {
  default = "10.0.0.0/16"
}

# Multi-AZ配備するときのAZ1
variable "availability_zone_1" {
  default = "ap-northeast-1c"
}

# Multi-AZ配備するときのAZ2
variable "availability_zone_2" {
  default = "ap-northeast-1b"
}

# AZ1のPublic SubnetのCIDR
variable "public_subnet_1_cidr_block" {
  default = "10.0.11.0/24"
}

# AZ1のPrivate SubnetのCIDR
variable "private_subnet_1_cidr_block" {
  default = "10.0.15.0/24"
}

# AZ2のPublic SubnetのCIDR
variable "public_subnet_2_cidr_block" {
  default = "10.0.51.0/24"
}

# AZ2のPrivate SubnetのCIDR
variable "private_subnet_2_cidr_block" {
  default = "10.0.55.0/24"
}

# 全ノードのCIDR
variable "cidr_all_node" {
  default = "0.0.0.0/0"
}

# SSH許可対象のCIDR
variable "cidr_ssh" {
  default = "0.0.0.0/0"
}

# ELBのヘルスチェックに使うAPIのパス
variable "elb_health_check_endpoint" {
  default = "/index.html"
}

# 踏み台サーバのSSH公開鍵
# ssh-keygen -b 4096 -t rsa -f ... で作成
variable "ec2_bastion_instance_ssh_public_key" {
  default = ""
}

# App/worker/esサーバのSSH公開鍵
# ssh-keygen -b 4096 -t rsa -f ... で作成
variable "ec2_app_instance_ssh_public_key" {
  default = ""
}

# EC2インスタンス作成時に使うami（Ubuntu 14.04）
variable "ec2_ami" {
  default = "ami-0567c164"
}

# 踏み台サーバのインスタンスタイプ
variable "ec2_bastion_instance_type" {
  default = "t2.nano"
}

# 踏み台サーバの汎用SSDストレージサイズ
variable "ec2_bastion_gp2_size" {
  default = "20"
}

# Appサーバのインスタンスタイプ
variable "ec2_app_instance_type" {
  default = "t2.small"
}

# Workerサーバのインスタンスタイプ
variable "ec2_worker_instance_type" {
  default = "t2.small"
}

# Appサーバの汎用SSDストレージサイズ
variable "ec2_app_gp2_size" {
  default = "30"
}

# Workerサーバの汎用SSDストレージサイズ
variable "ec2_worker_gp2_size" {
  default = "30"
}

# RDSのDBエンジン
variable "rds_instance_engine" {
  default = ""
}

# RDSのDBバージョン
variable "rds_instance_engine_version" {
  default = "5.7.16"
}

# RDSのDBParameterGroup Family
variable "rds_parameter_group_family" {
  default = "mysql5.7"
}

# RDSのポート
variable "rds_instance_port" {
  default = "3306"
}

# RDSのインスタンスタイプ
variable "rds_instance_type" {
  default = "db.t2.medium"
}

# RDSの汎用SSDストレージサイズ
variable "rds_instance_gp2_size" {
  default = "100"
}

# RDSのユーザ名
variable "rds_username" {
  default = ""
}

# RDSのパスワード
variable "rds_password" {
  default = ""
}

# RDSのMulti-AZ
variable "rds_multi_az" {
  default = "false"
}

# Notification SNS for alarms
variable "alarms_arn" {
  default = ""
}

# ALBで使用するドメイン
variable "alb_domain" {
  default = "{{ alb_domain }}"
}

variable "alb_listener_rule_condition" {
  default = "/target/*"
}
