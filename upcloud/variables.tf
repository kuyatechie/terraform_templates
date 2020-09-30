variable "private_key_file" {
  default = "<insert_your_private_key_here>"
}

variable "public_key" {
    type = list
    default = ["<insert_your_public_key_here>"]
}

variable "zones" {
    type = map
    default = {
        "amsterdam" = "nl-ams1"
        "london"    = "uk-lon1"
        "frankfurt" = "de-fra1"
        "helsinki1" = "fi-hel1"
        "helsinki2" = "fi-hel2"
        "chicago"   = "us-chi1"
        "sanjose"   = "us-sjo1"
        "singapore" = "sg-sin1"
    }
}

variable "plans" {
    type = map
    default = {
        "1CPU"  = "1xCPU-2GB"
        "2CPU"  = "2xCPU-4GB"
	    "4CPU"  = "4xCPU-8GB"
    }
}

variable "templates" {
    type = map
    default = {
        "ubuntu1604" = "01000000-0000-4000-8000-000030060200"
        "ubuntu1804"  = "01000000-0000-4000-8000-000030080200"
        "ubuntu2004"  = "01000000-0000-4000-8000-000030200200"
    }
}

variable "storage_sizes" {
    type = map
    default = {
        "1xCPU-2GB"  = "50"
        "2xCPU-4GB"  = "80"
	    "4xCPU-8GB"  = "160"
    }
}

variable "admin_ip" {
    type = map
    default ={
        "user" = "<insert_your_public_ip_here>"
    }
}
