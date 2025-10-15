# -------------------------
#### LXC Configuration ####
# -------------------------

# id=pve2/lxc/101
resource "proxmox_lxc" "nextcloud_lxc" {
  arch                 = "amd64"
  bwlimit              = 0
  clone                = null
  clone_storage        = null
  cmode                = ""
  console              = true
  cores                = 1
  cpulimit             = 0
  cpuunits             = 1024
  description          = ""
  force                = false
  full                 = null
  hagroup              = null
  hastate              = null
  hookscript           = null
  hostname             = "nextcloud"
  ignore_unpack_errors = false
  lock                 = null
  memory               = 1024
  nameserver           = null
  onboot               = true
  ostemplate           = null
  ostype               = "alpine"
  password             = null # sensitive
  pool                 = null
  protection           = false
  restore              = false
  searchdomain         = null
  ssh_public_keys      = null
  # start                = null
  startup              = null
  swap                 = 512
  tags                 = "alpine;cloud;community-script;nextcloud"
  # target_node          = "pve2"
  template             = false
  tty                  = 2
  unique               = false
  unprivileged         = false
  vmid                 = 101
  rootfs {
    acl       = false
    quota     = false
    replicate = false
    ro        = false
    shared    = false
    size      = "15G"
    storage = ""
    # storage   = "local-lvm"
  }
}

# id=pveprox/lxc/102
resource "proxmox_lxc" "k3s_vm" {
    cmode                = ""
    cores                = 2
    hostname             = "k3s-master" 
    # id                   = "pveprox/lxc/102"
    memory               = 4096
    swap                 = 2048
    start                = null
    tags                 = "kubernetes"
    unprivileged         = true 
    vmid = 102
    # target_node = "pveprox"

    rootfs {
          acl       = false 
          quota     = false 
          replicate = false
          ro        = false 
          shared    = false 
          size      = "80G" 
          # volume    = "lvm-thin-ext:vm-102-disk-1" 
          # storage   = "lvm-thin"
          storage = ""
      }
}

# id=pveprox/lxc/100
resource "proxmox_lxc" "openweb_ui" {
    memory = 4096
    cores = 2
    vmid = 100
    tags = "ai;community-script;interface"
    unprivileged = false
    cmode = ""
    hostname             = "openwebui"
    onboot               = true 
    searchdomain         = "local"
    swap                 = 4096
    rootfs {
        acl       = false
        quota     = false
        replicate = false
        ro        = false
        shared    = false
        size      = "50G"
        storage   = ""
        # volume    = "local-lvm:vm-100-disk-0"
      }
}



## Config for new LXC
# resource "proxmox_lxc" "lxc-test" {
#     features {
#         nesting = true
#     }
#     hostname = "terraform-new-container"
#     network {
#         name = "eth0"
#         bridge = "vmbr0"
#         ip = "dhcp"
#         ip6 = "dhcp"
#     }
#     ostemplate = "local:vztmpl/ubuntu-20.04-standard_20.04.1-1_amd64.tar.gz"
#     password = "password"
#     pool = "terraform"
#     target_node = "pve2"
#     unprivileged = true
# }