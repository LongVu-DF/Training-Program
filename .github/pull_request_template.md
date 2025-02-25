## What?
I've added support for authentication to implement Key Result 2 of OKR1. It includes model, table, controller and test. For more background, see ticket
#2131.
## Why?
These changes complete the user login and account creation experience. See #2131 for more information.
## How?
This includes a migration, model and controller for user authentication. I'm using Devise to do the heavy lifting. I ran Devise migrations and those are included here.
## Testing?
- Functional Testing: Pass
- Security: Pass
- Performance: Pass
- Error Handling: 75%
  - Check for efficient use of resources (CPU, memory): The used CPU increases 25% when using login API. Will improve on the next PR 
- Code Quality: Pass
- Documentation: Pass
- Database: Pass
- Deployment: Pass
- Final Review: Pass
## Screenshots (optional)
0
## Anything Else?
Let's consider using a 3rd party authentication provider for this, to offload MFA and other considerations as they arise and as the privacy landscape evolves. AWS Cognito is a good option, so is Firebase. I'm happy to start researching this path. Let's also consider breaking this out into its own service. We can then re-use it or share the accounts with other apps in the future.