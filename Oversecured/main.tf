resource "aws_iam_user" "oversecured_user" {
  name          = var.user_name
  path          = var.user_path
  force_destroy = true
}

resource "aws_iam_user_login_profile" "oversecured" {
  user    = aws_iam_user.oversecured_user.name
}

resource "aws_iam_policy" "check_right" {
  name        = "test-policy"
  description = "A test policy"
  policy      = {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:GetResourcePolicy",
                "ec2:GetManagedPrefixListEntries",
                "ec2:GetIpamResourceCidrs",
                "ec2:GetIpamPoolCidrs",
                "ec2:GetInstanceUefiData",
                "ec2:GetCoipPoolUsage",
                "ec2:ExportClientVpnClientConfiguration",
                "ec2:GetCapacityReservationUsage",
                "ec2:ModifySecurityGroupRules",
                "ec2:GetConsoleScreenshot",
                "ec2:GetAssociatedEnclaveCertificateIamRoles",
                "ec2:UpdateSecurityGroupRuleDescriptionsIngress",
                "ec2:GetConsoleOutput",
                "ec2:GetIpamAddressHistory",
                "ec2:ExportClientVpnClientCertificateRevocationList",
                "ec2:GetPasswordData",
                "ec2:GetLaunchTemplateData",
                "ec2:GetFlowLogsIntegrationTemplate",
                "ec2:GetManagedPrefixListAssociations",
                "ec2:GetIpamDiscoveredResourceCidrs",
                "ec2:GetIpamDiscoveredAccounts"
            ],
            "Resource": [
                "arn:aws:ec2:*:445545530422:placement-group/*",
                "arn:aws:ec2:*:445545530422:security-group-rule/*",
                "arn:aws:ec2:*:445545530422:security-group/*",
                "arn:aws:ec2::445545530422:ipam-pool/*",
                "arn:aws:ec2::445545530422:ipam-scope/*",
                "arn:aws:ec2:*:445545530422:client-vpn-endpoint/*",
                "arn:aws:ec2:*:445545530422:prefix-list/*",
                "arn:aws:ec2:*:445545530422:coip-pool/*",
                "arn:aws:ec2:*:445545530422:verified-access-group/*",
                "arn:aws:acm:*:445545530422:certificate/*",
                "arn:aws:ec2:*:445545530422:capacity-reservation/*",
                "arn:aws:ec2::445545530422:ipam-resource-discovery/*",
                "arn:aws:ec2:*:445545530422:vpc-flow-log/*",
                "arn:aws:ec2:*:445545530422:instance/*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "ec2:GetDefaultCreditSpecification",
                "ec2:GetSerialConsoleAccessStatus",
                "ec2:GetAssociatedIpv6PoolCidrs",
                "ec2:GetEbsEncryptionByDefault",
                "ec2:GetSpotPlacementScores",
                "ec2:GetHostReservationPurchasePreview",
                "ec2:GetEbsDefaultKmsKeyId",
                "ec2:GetNetworkInsightsAccessScopeAnalysisFindings",
                "ec2:GetNetworkInsightsAccessScopeContent",
                "ec2:GetSubnetCidrReservations",
                "ec2:GetAwsNetworkPerformanceData",
                "ec2:GetReservedInstancesExchangeQuote"
            ],
            "Resource": "*"
        }
    ]
}

}

resource "aws_iam_user_policy_attachment" "check_right_user" {
  user       = aws_iam_user.oversecured_user.name
  policy_arn = aws_iam_policy.check_right.arn
}