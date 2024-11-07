# Pro Tips

- Direct Connect may be a more complex and costlier option to setup, but it could save big on bandwidth costs
- Explicitly deny as much traffic as you can with NACLs. With Security Groups you allow traffic you want and the final implicit deny rule takes care of the rest. (Follow principle of least privilege) You want to make your internet facing attack service as small as possible
- Think of your VPC layout (see 2017 re:Invent video "Networking Many VPCs: Transit and Shared Architecture)
- You can use Route 53 for your domain even if AWS isn't your registrar, you just have to update your DNS entries with your registrar to use the AWS ones assigned when you created your hosted zone
- ELBs provide a useful layer of abstraction (as does Route 53 too!)