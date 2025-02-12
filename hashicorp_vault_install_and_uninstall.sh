2025-02-12T02:41:18.8293118Z Requested runner group: vpay-runner-group
2025-02-12T02:41:18.8293369Z Job defined at: tpay-financial/vpay-generation/.github/workflows/offload-bamboo-queue-processor.yml@refs/heads/test-changes-on-prod-environment
2025-02-12T02:41:18.8293473Z Waiting for a runner to pick up this job...
2025-02-12T02:41:19.1627224Z Job is about to start running on the runner: vpay-mo066inflrun01 (organization)
2025-02-12T02:41:22.2114424Z Current runner version: '2.322.0'
2025-02-12T02:41:22.2123138Z Runner name: 'vpay-mo066inflrun01'
2025-02-12T02:41:22.2124258Z Runner group name: 'vpay-runner-group'
2025-02-12T02:41:22.2125524Z Machine name: 'mo066inflrun01'
2025-02-12T02:41:22.2131501Z ##[group]GITHUB_TOKEN Permissions
2025-02-12T02:41:22.2135094Z Actions: write
2025-02-12T02:41:22.2135871Z Attestations: write
2025-02-12T02:41:22.2136667Z Checks: write
2025-02-12T02:41:22.2137662Z Contents: write
2025-02-12T02:41:22.2138437Z Deployments: write
2025-02-12T02:41:22.2139252Z Discussions: write
2025-02-12T02:41:22.2140015Z Issues: write
2025-02-12T02:41:22.2140735Z Metadata: read
2025-02-12T02:41:22.2141530Z Packages: write
2025-02-12T02:41:22.2142279Z Pages: write
2025-02-12T02:41:22.2143114Z PullRequests: write
2025-02-12T02:41:22.2143931Z RepositoryProjects: write
2025-02-12T02:41:22.2144773Z SecurityEvents: write
2025-02-12T02:41:22.2145587Z Statuses: write
2025-02-12T02:41:22.2146348Z ##[endgroup]
2025-02-12T02:41:22.2149481Z Secret source: Actions
2025-02-12T02:41:22.2150741Z Prepare workflow directory
2025-02-12T02:41:22.2809719Z Prepare all required actions
2025-02-12T02:41:22.2856184Z Getting action download info
2025-02-12T02:41:22.4846768Z Download action repository 'actions/checkout@v4' (SHA:11bd71901bbe5b1630ceea73d27597364c9af683)
2025-02-12T02:41:23.5002559Z Download action repository 'actions/upload-artifact@v4' (SHA:65c4c4a1ddee5b72f698fdd19549f0f0fb45cf08)
2025-02-12T02:41:24.3133228Z Complete job name: build
2025-02-12T02:41:24.4046919Z ##[group]Run actions/checkout@v4
2025-02-12T02:41:24.4048583Z with:
2025-02-12T02:41:24.4049620Z   repository: tpay-financial/vpay-generation
2025-02-12T02:41:24.4051293Z   token: ***
2025-02-12T02:41:24.4052214Z   ssh-strict: true
2025-02-12T02:41:24.4053147Z   ssh-user: git
2025-02-12T02:41:24.4054205Z   persist-credentials: true
2025-02-12T02:41:24.4055262Z   clean: true
2025-02-12T02:41:24.4056562Z   sparse-checkout-cone-mode: true
2025-02-12T02:41:24.4058090Z   fetch-depth: 1
2025-02-12T02:41:24.4059071Z   fetch-tags: false
2025-02-12T02:41:24.4060026Z   show-progress: true
2025-02-12T02:41:24.4060988Z   lfs: false
2025-02-12T02:41:24.4061878Z   submodules: false
2025-02-12T02:41:24.4062852Z   set-safe-directory: true
2025-02-12T02:41:24.4064376Z env:
2025-02-12T02:41:24.4065589Z   VAULT_ADDR: ***
2025-02-12T02:41:24.4066668Z   VAULT_TOKEN: ***
2025-02-12T02:41:24.4067594Z ##[endgroup]
2025-02-12T02:41:24.5297290Z Syncing repository: tpay-financial/vpay-generation
2025-02-12T02:41:24.5300558Z ##[group]Getting Git version info
2025-02-12T02:41:24.5302787Z Working directory is '/home/gitrunner/actions-runner/_work/vpay-generation/vpay-generation'
2025-02-12T02:41:24.5305488Z [command]/usr/bin/git version
2025-02-12T02:41:24.5306572Z git version 2.34.1
2025-02-12T02:41:24.5309939Z ##[endgroup]
2025-02-12T02:41:24.5317806Z Temporarily overriding HOME='/home/gitrunner/actions-runner/_work/_temp/2db0b082-5df8-41d9-b42e-058f725b7ed2' before making global git config changes
2025-02-12T02:41:24.5321130Z Adding repository directory to the temporary git global config as a safe directory
2025-02-12T02:41:24.5324333Z [command]/usr/bin/git config --global --add safe.directory /home/gitrunner/actions-runner/_work/vpay-generation/vpay-generation
2025-02-12T02:41:24.5354472Z [command]/usr/bin/git config --local --get remote.origin.url
2025-02-12T02:41:24.5371667Z https://github.com/tpay-financial/vpay-generation
2025-02-12T02:41:24.5386570Z ##[group]Removing previously created refs, to avoid conflicts
2025-02-12T02:41:24.5390139Z [command]/usr/bin/git rev-parse --symbolic-full-name --verify --quiet HEAD
2025-02-12T02:41:24.5406690Z refs/heads/test-changes-on-prod-environment
2025-02-12T02:41:24.5414932Z [command]/usr/bin/git checkout --detach
2025-02-12T02:41:24.5460695Z HEAD is now at c39cc66b testing workflow for prod environment
2025-02-12T02:41:24.5496300Z [command]/usr/bin/git branch --delete --force test-changes-on-prod-environment
2025-02-12T02:41:24.5523282Z Deleted branch test-changes-on-prod-environment (was c39cc66b).
2025-02-12T02:41:24.5587367Z ##[endgroup]
2025-02-12T02:41:24.5588469Z [command]/usr/bin/git submodule status
2025-02-12T02:41:24.5792792Z ##[group]Cleaning the repository
2025-02-12T02:41:24.5795071Z [command]/usr/bin/git clean -ffdx
2025-02-12T02:41:24.5831192Z [command]/usr/bin/git reset --hard HEAD
2025-02-12T02:41:24.5878305Z HEAD is now at c39cc66b testing workflow for prod environment
2025-02-12T02:41:24.5883148Z ##[endgroup]
2025-02-12T02:41:24.5884885Z ##[group]Disabling automatic garbage collection
2025-02-12T02:41:24.5887852Z [command]/usr/bin/git config --local gc.auto 0
2025-02-12T02:41:24.5908967Z ##[endgroup]
2025-02-12T02:41:24.5910711Z ##[group]Setting up auth
2025-02-12T02:41:24.5914086Z [command]/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
2025-02-12T02:41:24.5946791Z [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :"
2025-02-12T02:41:24.6143041Z [command]/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
2025-02-12T02:41:24.6168883Z [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :"
2025-02-12T02:41:24.6364487Z [command]/usr/bin/git config --local http.https://github.com/.extraheader AUTHORIZATION: basic ***
2025-02-12T02:41:24.6397041Z ##[endgroup]
2025-02-12T02:41:24.6398664Z ##[group]Fetching the repository
2025-02-12T02:41:24.6405644Z [command]/usr/bin/git -c protocol.version=2 fetch --no-tags --prune --no-recurse-submodules --depth=1 origin +51399e96ead902d990811d1aec5893391002d4d7:refs/remotes/origin/test-changes-on-prod-environment
2025-02-12T02:41:24.6507578Z ##[error]error: cannot open .git/FETCH_HEAD: Permission denied
2025-02-12T02:41:24.6517414Z The process '/usr/bin/git' failed with exit code 255
2025-02-12T02:41:24.6518917Z Waiting 17 seconds before trying again
2025-02-12T02:41:41.6594301Z [command]/usr/bin/git -c protocol.version=2 fetch --no-tags --prune --no-recurse-submodules --depth=1 origin +51399e96ead902d990811d1aec5893391002d4d7:refs/remotes/origin/test-changes-on-prod-environment
2025-02-12T02:41:41.6694627Z ##[error]error: cannot open .git/FETCH_HEAD: Permission denied
2025-02-12T02:41:41.6726898Z The process '/usr/bin/git' failed with exit code 255
2025-02-12T02:41:41.6727493Z Waiting 10 seconds before trying again
2025-02-12T02:41:51.6832833Z [command]/usr/bin/git -c protocol.version=2 fetch --no-tags --prune --no-recurse-submodules --depth=1 origin +51399e96ead902d990811d1aec5893391002d4d7:refs/remotes/origin/test-changes-on-prod-environment
2025-02-12T02:41:51.6921926Z ##[error]error: cannot open .git/FETCH_HEAD: Permission denied
2025-02-12T02:41:51.6973704Z ##[error]The process '/usr/bin/git' failed with exit code 255
2025-02-12T02:41:51.7358230Z Post job cleanup.
2025-02-12T02:41:51.8407842Z [command]/usr/bin/git version
2025-02-12T02:41:51.8447176Z git version 2.34.1
2025-02-12T02:41:51.8493801Z Temporarily overriding HOME='/home/gitrunner/actions-runner/_work/_temp/144a6ed8-85b4-489a-ab31-66e80016487d' before making global git config changes
2025-02-12T02:41:51.8495329Z Adding repository directory to the temporary git global config as a safe directory
2025-02-12T02:41:51.8499471Z [command]/usr/bin/git config --global --add safe.directory /home/gitrunner/actions-runner/_work/vpay-generation/vpay-generation
2025-02-12T02:41:51.8535587Z [command]/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
2025-02-12T02:41:51.8577966Z [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :"
2025-02-12T02:41:51.8798985Z [command]/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
2025-02-12T02:41:51.8820630Z http.https://github.com/.extraheader
2025-02-12T02:41:51.8831497Z [command]/usr/bin/git config --local --unset-all http.https://github.com/.extraheader
2025-02-12T02:41:51.8858830Z [command]/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :"
2025-02-12T02:41:51.9192239Z Cleaning up orphan processes
