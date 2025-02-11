# **Trainning program**

## 1. Familiarity with Github

### Basic know about Github: ✅

- **Github account:** Created Github account with email <ins>long.vu@digitalfortress.dev<ins>.
- **Terminal/Command line basic understanding:** Created and configured SSH key, add SSH key into Github account.
- **Basic knownledge:**
  - **why version control importance:**
    - Easy to maintaince.
    - Working with multi device, multi teammate.
    - Keep old version, can change between each version.
- **Git & Github:**
  - Git is version control, store in pc memmory
  - Github is management UI use to store and share Git online.

### Know how to use Git: ✅

- **All Git syntax:** https://www.geeksforgeeks.org/git-cheat-sheet/

### Git flow:

- **Understand Gitflow:**
  - **Start:** create branch main and develop.
  - **Adding feature:** create new feture/namefeature and merge into develop.
  - **Fixbug:** create new fixbug/\* and merge into develop.
  - **Ready to release:** create release/\* branch and testing error.
  - **Releasing:** merge into main, create tag then merge into develope.
  - **Hotfix:** if code from main have bug, create hotfix/\* branch then merge into main and develop.
- **Release management:**
  - **Planing:**
    - Estimate the scope of the release.
    - Make schedule release.
    - Identify resources needed.
  - **Development:**
    - Writing code, debug.
    - Review code and and unit test.
  - **Testing:**
    - Automated test....
  - **Deployment:**
    - Merge into main, create tag.
    - Production deploy.


- **Branching strategies:**  
   - **main (master)**: Release working code. - **develop**: development branch.  
   - **feature/\*** : checkout from _"develop"_, merge into _"main"_. Use to development feature.  
   - **fixbug/\*** : checkout from _"main"_, merge into _"main"_ and _"develop"_. Use to hotfix bug.  
  Ref: https://dev.to/basementdevs/be-a-better-developer-with-these-git-good-practices-2dim
