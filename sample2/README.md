# terra-module-2
building a module is quite simple and yet complicated .

step1:- build your resources ex:/ ec2 , vpc .....

step2:- declare variables you want to use with resources , and then print out their outputs .

step3:- These outputs can then be used as resource variables in some other resource for ex:// In our module in resource vpc , here vpc is declaring a output for vpc id ,         this output is then used as a resource in ec2 such as "module.ascentt-vpc.vpc_id" 

base line :- the outputs of one resource can be used as variables in some other resource by using terraform modules.
