variable "vpc_peer" {
  description = "Peering connections to create. peer_type is internal or external."
  type = list(object({
    peer_type                = string
    target_project_id        = string
    name                     = string
    vpc                      = string
    target_vpc               = string
    other_region             = string
    accepter_dns_resolution  = bool
    requester_dns_resolution = bool
  }))
}
