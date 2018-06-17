# tf-workshop
After [getting started] with Terraform, this intended to introduce _many_ concepts on a very basic level. The most noticeable thing about `tf-workshop` is there are design/implementation oddities almost everywhere - yet it still works. 

This is a training start-point; however, the end-goal is a hidden easter egg somewhere in this repo. You'll have to follow all the instructions to find it.

## Requirements
 * A POSIX laptop; a workstation will do though.
 * A Github account.
 * AWS Account Credentials
 
 After that, follow some initial account [security setup] steps.


## Instructions
Fork this repo, clone it down and `cd` into the directory:
```bash
git clone git@github.com:myGithubUser/tf-workshop.git && cd tf-workshop/
```

### `test_systems.sh`
This is a convenience wrapper to speed-up `apply`, `plan` and `destroy` operations; it also removes and cleans-up nicely to reset the environment. These are the usage details:

```bash
Description: Build or Destroy systems at will.

    Usage:   ./test_systems.sh [OPTION1] [OPTION2]...
    Example: ./test_systems.sh -v --ip-check

    OPTIONS:
    -t, --test       'terraform plan' operation
                      Initialize and plan a potential terraform build.
                      Example: ./test_systems.sh -t

    -b, --build       'terraform apply' operation
                      Build a new system from the *.tf files in the current directory.
                      Example: ./test_systems.sh --build

    -d, --destroy    'terraform destroy' operation
                      Destroy a system corresponding to the state files in the
                      current directory.
                      Example: ./test_systems.sh -v -d

    -c, --cleanup     After a glitch and manual intervention is required, reset
                      the state and remove the log file from the last run.
                      Example: ./test_systems.sh --cleanup

    -ip, --ip-check   Verify the current gateway address
                      Example: ./test_systems.sh -ip

    -r, --retest      Quickly rebuild a system; calls destroy, then builds again.
                      Example: ./test_systems.sh -v --retest

    -v, --verbose     Turn on 'set -x' debug output.

```

Initialization and planning are simple:

`./test_systems.sh --test`

If the plan looks good, then build it:

`./test_systems.sh --build`

At the end, a `pub_ip` will be output. Login to your system or just test that `nginx` is running:

`curl -4 http://$pub_ip` 

_NOTE: it does take a moment for the instance to become available. Be patient and retry if it doesn't work immediately._

When done with the inspection, log out of the instance:

```bash
admin@52.11.112.251:~$ exit
logout
Connection to 52.11.112.251 closed.
myHost:tf-workshop user$ 
```

The instance can be destroyed easily when you're done:

`./test_systems.sh --destroy`

So there are no lingering state files lying about, clean them up as well:

`./test_systems.sh --cleanup`

After that, it's time to make improvements and submit pull requests. This thing is horrible.

***

## Review
This is all well and good but we're still dragging the habits of the old data center into the modern cloud. To remedy that, check back to see **The _modern approach_ to deployments**. 

The modern approach will decrease complexity, increase security, and make (normally) complex deployments easier than you might think. Stay tuned...

[getting started]:https://www.terraform.io/intro/getting-started/install.html
[security setup]:https://github.com/todd-dsm/mac-ops/wiki/Install-awscli
[end-goal]:https://github.com/turnbullpress/tfb-code/tree/master/3/web
