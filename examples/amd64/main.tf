terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "<5.0"
    }

    random = { source = "hashicorp/random" }
  }
}

provider "aws" {
  region = "eu-west-1"
}

data "aws_vpc" "this" {
  default = true
}

data "aws_security_group" "this" {
  name   = "default"
  vpc_id = data.aws_vpc.this.id
}

data "aws_subnets" "this" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.this.id]
  }
}

data "worker_pool_id" "aws" {
  worker_pool_id = "01H02SJKBEX2HW1RC3WCX069MC"
}

#### Spacelift worker pool ####

module "this" {
  source = "../../"

  configuration   = <<-EOT
    export SPACELIFT_TOKEN="eyJicm9rZXIiOnsiZW5kcG9pbnQiOiJhcjM0enRleGs1M3FuLWF0cy5pb3QuZXUtd2VzdC0xLmFtYXpvbmF3cy5jb20iLCJwdWJsaXNoX2NoYW5uZWxfZm9ybWF0Ijoic3BhY2VsaWZ0L3dyaXRlb25seS8wMUgwMlNKS0JFWDJIVzFSQzNXQ1gwNjlNQy8lcyIsInN1YnNjcmliZV9jaGFubmVsX2Zvcm1hdCI6InNwYWNlbGlmdC9yZWFkb25seS8wMUgwMlNKS0JFWDJIVzFSQzNXQ1gwNjlNQy8lcyJ9LCJwb29sX2NlcnQiOiItLS0tLUJFR0lOIENFUlRJRklDQVRFLS0tLS1cbk1JSUVvakNDQTRxZ0F3SUJBZ0lVRDR3L21oTUJIM1I3NkZ2aWtBc21NRGtIZHZJd0RRWUpLb1pJaHZjTkFRRUxcbkJRQXdUVEZMTUVrR0ExVUVDd3hDUVcxaGVtOXVJRmRsWWlCVFpYSjJhV05sY3lCUFBVRnRZWHB2Ymk1amIyMGdcblNXNWpMaUJNUFZObFlYUjBiR1VnVTFROVYyRnphR2x1WjNSdmJpQkRQVlZUTUI0WERUSXpNRFV4TURFeU1Ua3hcbk0xb1hEVFE1TVRJek1USXpOVGsxT1Zvd1p6RUxNQWtHQTFVRUJoTUNWRkl4RGpBTUJnTlZCQWdNQlVsYVRVbFNcbk1RNHdEQVlEVlFRSERBVkpXazFKVWpFTE1Ba0dBMVVFQ2d3Q1RrRXhDekFKQmdOVkJBc01BazVCTVI0d0hBWURcblZRUUREQlZsYldsdUxtRndjQzV6Y0dGalpXeHBablF1YVc4d2dnSWlNQTBHQ1NxR1NJYjNEUUVCQVFVQUE0SUNcbkR3QXdnZ0lLQW9JQ0FRRE55R0I3Z0libEVLSVlZM2g1M1JDWkxScVN0NEhpQ1VBVEFCT09rY3lKNldpT0RPa1JcblBEcjNDbXRxZDFrd1ZSYmZWc1RkOVdTMzZqUU5GVVdVNEU3MWw3UTlYNWtqK2ROQ01MMlhIWE0zakI4Uk5nMUpcbnN4cHVHL0JRZzdjREs1MDlYU2U5ZlBrYTVpeXNhbmZJTGMwMXIwRFlPNXBVM0p3bHJXM09ieWp5VlBHcjM1UnpcbmNnZlNqQUlPZUx4VE42dGtnLzdsOGhZbFBLYUZkOE5PQ3l3OFh2ZVo2Y3NSdy95RHI0eXp4c0JuamszU1RMY1FcblY5TXdQOWNRK2JlRUk2NU5rSGhqZloyc1hjK0RhNGpLN3BRMndySDRWZWVsSUI0M3hBNWdNMFo2MnhrbEl5NW1cbnNhYkM4dC9oRkpXR1FjT0JCaHFCS2ZCOGxVaWZZeUhhRzJXakwvTTRzdjJwWGx5dGs1ZWN6bHhRVHpsUzRUN1RcbnBkMVIvQ1VZdi9IRUNZMzhDenp2b1BvR1Q0ZEhLVEJUdGUrZXZJOENiSXFlRitnOGFUeFRPMnRocW51QkFzVUhcbmRSWG5LR0gxYjFTYkpJNnZVYU1adlo4Q1F5VysrSTBpTXBmRHJVUVdSeU8yOVFKelUzQ3N5WEg0MlB3VVZ5eFpcbk95YUxoMENiTG9ISElxaXhUOEdLTWE2aU5lSjROdkdxRjRZNVJJSXg5UGt6LzRsYldlSko4U2dNbVBNVEowOWJcbjA4bWxEZ01obUJsVnZzM01Uck4vWGF4blRUWGR4SmFHL0FEdHVDaUw2VWswNlBWNVowR0VqTk1PdG8wejcyOGZcbjlVZGpLY1VHVE1IZ29BRlVxNU9oV1VDaDRuWVlNMVpVcjZ2K3hPd0I4Z3lIZEtaK1pzSXU4Y1BLc1FJREFRQUJcbm8yQXdYakFmQmdOVkhTTUVHREFXZ0JRRHVUNUdEZzFSdnhxUnY5MlppSzBpY0YvM2tUQWRCZ05WSFE0RUZnUVVcbi83dnZ6N3VXUWtkOVFsOGZNcm10MzZFVnNKNHdEQVlEVlIwVEFRSC9CQUl3QURBT0JnTlZIUThCQWY4RUJBTUNcbkI0QXdEUVlKS29aSWh2Y05BUUVMQlFBRGdnRUJBRDFqVHBMRTRzWjNjMWZOaVNsaG01WDlNNXJ6UXd2RmFjditcbnFxaytIL05qa050emE2VWxZL0h0TkIveWRCZ000ZmNMSHIwcmI4d3l1eTVNeWU5WlBWWC9VYkprOUpkSUZPVHhcbjMyWHpEdTdyNUVXRW5NUUZIYUVyVEVPc0FTdFhXeHFaU1NLcmtoU0ZEVFZYRzlyaldVdnVDUFM5MFovbHZybUxcbnBRV0lZZWlnZU1tV1JKbzkyT2lqZFdIN1dJSTNPTWNndXFGSGRSeWdUb0dCUDlhcXgrd2lhOTZwK3JMUHliSjZcbmxoUUdIRzRHZnpkMDFlVWtMaEs2cnk1RndFYUFFMDRIcWJwTkUxYWdPWWduMjFFOThWcmhGeHU2empKcUpFbU5cbmRnMXJheml6TzVSaTFuYWdhQ2JOR3hQR0xGcWVjZ3UyVEZLakxScnNPcTFFS25PamNqRT1cbi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS1cbiIsIndvcmtlcl9wb29sX3VsaWQiOiIwMUgwMlNKS0JFWDJIVzFSQzNXQ1gwNjlNQyJ9"
    export SPACELIFT_POOL_PRIVATE_KEY="LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUpSQUlCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQ1M0d2dna3FBZ0VBQW9JQ0FRRE55R0I3Z0libEVLSVkKWTNoNTNSQ1pMUnFTdDRIaUNVQVRBQk9Pa2N5SjZXaU9ET2tSUERyM0NtdHFkMWt3VlJiZlZzVGQ5V1MzNmpRTgpGVVdVNEU3MWw3UTlYNWtqK2ROQ01MMlhIWE0zakI4Uk5nMUpzeHB1Ry9CUWc3Y0RLNTA5WFNlOWZQa2E1aXlzCmFuZklMYzAxcjBEWU81cFUzSndsclczT2J5anlWUEdyMzVSemNnZlNqQUlPZUx4VE42dGtnLzdsOGhZbFBLYUYKZDhOT0N5dzhYdmVaNmNzUncveURyNHl6eHNCbmprM1NUTGNRVjlNd1A5Y1ErYmVFSTY1TmtIaGpmWjJzWGMrRAphNGpLN3BRMndySDRWZWVsSUI0M3hBNWdNMFo2MnhrbEl5NW1zYWJDOHQvaEZKV0dRY09CQmhxQktmQjhsVWlmCll5SGFHMldqTC9NNHN2MnBYbHl0azVlY3pseFFUemxTNFQ3VHBkMVIvQ1VZdi9IRUNZMzhDenp2b1BvR1Q0ZEgKS1RCVHRlK2V2SThDYklxZUYrZzhhVHhUTzJ0aHFudUJBc1VIZFJYbktHSDFiMVNiSkk2dlVhTVp2WjhDUXlXKworSTBpTXBmRHJVUVdSeU8yOVFKelUzQ3N5WEg0MlB3VVZ5eFpPeWFMaDBDYkxvSEhJcWl4VDhHS01hNmlOZUo0Ck52R3FGNFk1UklJeDlQa3ovNGxiV2VKSjhTZ01tUE1USjA5YjA4bWxEZ01obUJsVnZzM01Uck4vWGF4blRUWGQKeEphRy9BRHR1Q2lMNlVrMDZQVjVaMEdFak5NT3RvMHo3MjhmOVVkaktjVUdUTUhnb0FGVXE1T2hXVUNoNG5ZWQpNMVpVcjZ2K3hPd0I4Z3lIZEtaK1pzSXU4Y1BLc1FJREFRQUJBb0lDQUhQYXlUOGUrRk5Fanc0T0Nva0poY3ZIClVmdWlKeFM4UW4rdi9sSzVFUi9mOGdadmpGUXd4YjNKOXZuRTRjak5Ud2hFa0tlcC9aOXgwd1krb0tNVnVqNlkKdjFnQ1YzU2l0V2JCakN2azM3WTVSRkJyVHdYY09SZ2UwS2h6ejNpUWVJRlF6Z3ZuclZPUW5Ud2c0UGtwbUN3TwpWQUtwWTlVOU13Z2ZZUC9sSTNkempYQkhld3VYK29GMlk3NEVDWHNNajRrU3ExS0lmaUZPeVMzQlpJcXV6YVBiCmo2anVzRzU3R2RLRjVrQmN1SHhVNk1scWVYSlJEOHhOVk9id3dIbzdvR2w0MmQ2aG5VQ3F2Q2J3UnQ2QmZaNXEKOU1tc2k3TXlwdkNjaDc5dmZ0R3lRckRlNHNQY1p0ZkE1M3lRR3pLd0djS3RUZ1RFT09uYkhqem1FZXY2bXJoSAoxdGZvY0JDMTNPWFJCVk5mVDExbElQTlJsMEd1K0twNnlJRjZ4dXFRbi9IVk9BNTJNN09HSTVFazcwdkpQUUhGCjhpYkNwUU0xWHlrSXc1cXZDTjFZMHIyNUZEalFyRmhMSG1iWFJ0VXorendNZU5mVE8xN1lQZzBnaTgxOU9HNUEKcWFvMExzMHorYzRjemxlbDUyNDZQVWN0ZS95b2JweVAwU214VWNEOGRoblZ3U245K3B3bktJR2MwaUx5M2JSZgpHeVRKVGN4c2NycS9qM2crdjZIejk5NE1ncElkTzhJbEkxQm9rbjZoZTBEb2JFOGdjYWZXYnRjMEpFM2toL2EyCnVnait4aklHRkR5TjJ0V1F5U2xpbExQLzJMVDNwaHZSaGJEZ2s2RWxPdkJTSjJWQjhvREs5Y25aaDVRUllFMDQKL0FWQnNyS0czN2kxYkVVZGg5UDFBb0lCQVFEbS9RbFBIU3A4RVF2TzN3N3hpcU9QS21mV3Rib01zay9nOXFYegorL3dpM2lucGJmOVdpMkExb1BnaWtwaG1jOWFNeVRhUkdKSkZ0OVo1NmpML1ZxWGZ6dVllMndLWFRUdFdEMGdLCmNOUTBzTElVWm1CbUpkV0x2dFdNcG1CcUIrZ1QzaFM0TTBOazFad3l1eGcveldPRjBRV3A4R1BaZlQxYUVzT2YKZXhiSGpiS3Q1eTRsemxJcEpiZVNSc2dVOXJPdS95S21OM2ZDc3pwZVVhSHJBVERZbGNJOFRhelZmRE1ibm5mdApwVkFaUCtPc2RJODEvdUV5MVVpcktCcFZsTG5RU1lraXViZElVL0ltVExpNWhOZUMxNkxiVmZURlNjK1Mvek4xClpvOVlGU0JsRU95d0FUMzBBS0lldkd5aS9hakFJdjhqYldIZ1pCMVlMYjlVbjNRYkFvSUJBUURrRUtSeGNQMkIKMllxMDBVZC9YcXN2aWhib2FNbG5sYi8wTmFDdktlWUVLQ2xMdzc0WFFUTElLcWUvblRoZVVhT2FCTEdGWmlzLwpveHJ0RnRYcU12ZTlmYkVkWFBPYTBKOWtXTjNUUUdZeENQR1FieThIQ1h1Q2VsWVhSUEY0UW1jc3pVTUZpcGh4CkFqQytwQ0psSSt0M0lDUCtHdWtsZjRDbjliL3psQzlpOGU2Z2NjdVNFSDJwenJKRm1nRDBXb0ZQdDNqU09hMnQKOU5KOUNiV0Vjd1Yrbm5yWDFzQ2NaQndVZWtIM3dMTzJtRzVyUmRFb0hBaTR1eFpXZ3hSTXZYUm4zTXJqdE9xKwpQNXlSUGlhMlE1UUFyWXlORERJTUFpRzIyOG1LeWk5NmxjY2FDQkhQdkZRMHkydWJ4TllKeHp1eGE2N2dsQUNmClJMOTZkbXJlbFhFakFvSUJBUURoVEwrdXRnRUJZRk1ISlpSYXptSTRPeUZyVUhlMitKbG5FTXpQak9IaVZKWEcKeEc2QVNKTy8yMUVMejdic2YySXVrZmd5VUNnajdtczVJTkU3TXBXNkZnRm82UysreWlydEJ4eTZhbERoVDlOeQppR1RRWFdqTDFJaFFsdHVGc0U2U1NsUWxVb01Tc0RPWlc5b01LVlpBYUo5QW9XT1MrRkJHTWZVeThnbEcvUlBpCkFaS0dkNWExNGI4SzR4VTNOV1lQYzNXbGNJYlVscUtBNnRpbTh0TmsvYldsd2hHcGJXb2dMMUpFcnJEUTMvcysKODdYWDhkSlFGYTY2bXZRTXMzTUdFU084aGk2YVVwN204b0JmRzQ1bFpkVElZUy9NMnZDbkxWcFEwWWRSWDlIbwpJampxZDF1cFNwRFdyK3k2a2ZYdDZuUzNabkpJUHY1TVN0ckxQSGd2QW9JQkFRQ0RFWTF3SkorTW9KazJrWStsCmc2S2VENTVhc3Q0TXllTW5WaXFpZ0ZIUTBjUHA1dlM0S0tBbXFWeitvanhpK0VndG04VHFCVzJWaFFkVWVtczEKelZUVGNnajM5eE9KUlp4VTd6Mk15dFh3R0ZPN3ppb1l3VHBhSWpTWDZ1ZGJWYzQxMFVGVFRmT04vdFJFdTgrSQprTHdpR2phVk1xSUxDdHZGcTFaRmhrUTFlUlRLNEpzOXRueUJ1bWg1MTZmMHhvN0tZWWJ1U25lbUlhMVdidDRDCjRKZW56U3lNSHI5VEliV0JqMEdhUVFVSFMxTXFFMVhBMTF1cnp0bG5ucTFyN1BXWk95cmU4bnAyRzlpL0lCamYKWnJjSUxMVTUybWhvdmxEaDVpNU50U1RVTG4vZVZnVG1malZtb2dHVjQrbWVkUUc1VlVtTGg0TlVCUTZHTXNmNApZNnBCQW9JQkFRQ3pDa2QrK0hmbzBzUUppZVRBc3hYSGkyMHVPMDdQaHFOYkZBSEhLNWFkS0RxaitDSWlOQTdCCmhlcEx4ZDB6bktNZXgxSXB3YW9ubWExM2RjUUkzYjFSbW5EM0tCZzNlUEE5NVd3KzlyK2xuSExMYXFPZ0w3VWcKL0RZUkhmd0QzZjFEMHhMWFUvKzIrQmhJV3NINlJUT2ozS2hZcFg2Y3dwdi9pWlcyMTRJRU9QRk8wZnJ1WS9NQQpXWjJQZ05KQmFJMC9nNnhVSUR3cm5WZ3NuSUd5MjJuMndrNllQdmJCVmhPcjlwTzcrallxQzdYUUdjcEZKWWpECnRIV3NSMkUxd3k4TXJhaUhyVUR0M2MwdU5hejZtc1hNeUpVd1pXRXlQbkVsNnBUVW1IZyszTFYxSG9pbVdxUUYKS3VmVXJJWEVYQ0FXVGxZMndlSWFYOFVRYTNkUDFBRlQKLS0tLS1FTkQgUFJJVkFURSBLRVktLS0tLQo="
  EOT
  security_groups = [data.aws_security_group.this.id]
  vpc_subnets     = data.aws_subnets.this.ids
  worker_pool_id  = data.worker_pool_id.aws
}
