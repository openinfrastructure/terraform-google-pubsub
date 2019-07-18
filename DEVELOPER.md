Development
===

Automated tests are intended to run locally exactly as they run in CI.  To
accomplish this, the following assumptions are made:

 1. Test configuration is handled solely via environment variables, e.g.
    project identifier.
 2. Requirements of the host test runner are minimal.
 3. In development, the host test runner is your workstation.
 4. In CI, the host test runner is the CI runner.

CI Host runner requirements
---

 * Docker to unify a local host runner with ci runners.
 * Python 3.7 to share and re-use tasks across CFT projects
 * make to provide a convenient starting point

Development Host runner requirements
---

All of the CI Host runner requirements plus

 * [virtaulenv][virtualenv] to easily manage and isolate shared task libraries
   when working with multiple CFT modules on one development workstation.
 * [direnv][direnv] to easily manage environment variables when working with
   multiple modules.

Install System Dependencies
===

macOS
---

Install [Docker Desktop for Mac][docker-mac]

Install additional dependencies using [Homebrew][brew].

```bash
brew install python3 virtualenv direnv
```

Install Project Dependencies
---

Install project level dependencies using virtualenv.  The main project level
dependency is the [cftasks][cftasks] library containing shared tasks for re-use
across CFT modules.

```bash
virtualenv --no-site-packages --distribute .env
source .env/bin/activate
```

[virtualenv]: https://virtualenv.pypa.io/en/latest/
[docker-mac]: https://hub.docker.com/editions/community/docker-ce-desktop-mac
[brew]: https://brew.sh/
[cftasks]: https://github.com/openinfrastructure/cftasks
