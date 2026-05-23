# Jenkins setup

Custom Jenkins image with Maven and Docker CLI pre-installed, used to run the CI pipeline for this project locally.

## Layout

- `Dockerfile` — extends `jenkins/jenkins:lts-jdk17` and adds Maven + Docker CLI.
- `start-jenkins.ps1` — builds the image, creates a persistent volume, and starts Jenkins on port `8081`.

## First-time setup

Run from the `jenkins/` directory:

```powershell
.\start-jenkins.ps1
```

Then open http://localhost:8081 and paste the initial admin password printed by the script.

## Notes

- Jenkins runs on host port **8081** to avoid clashing with the Spring Boot app on `8080`.
- The host Docker socket is mounted into the container so Jenkins can build and push Docker images using the host's Docker daemon (no Docker-in-Docker).
- Jenkins data is persisted in a named volume `jenkins_home`, so stopping/restarting the container keeps jobs, credentials, and history.

## Common commands

```powershell
docker logs -f jenkins              # tail Jenkins logs
docker stop jenkins                 # stop Jenkins
docker start jenkins                # start it back
docker rm -f jenkins                # destroy the container (volume keeps data)
docker volume rm jenkins_home       # WIPE all Jenkins data (jobs, creds, etc.)
```
