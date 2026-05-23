# Build the custom Jenkins image (Jenkins LTS + Maven + Docker CLI)
docker build -t jenkins-ci:latest .

# Create a named volume for Jenkins data persistence (only created once)
docker volume create jenkins_home

# Run Jenkins
#   - port 8081 on host (avoids clash with the Spring Boot app on 8080)
#   - port 50000 for Jenkins agent connections (standard)
#   - mount the host Docker socket so Jenkins can run docker commands
#   - persist Jenkins data in the named volume
docker run -d `
    --name jenkins `
    --restart unless-stopped `
    -p 8081:8080 `
    -p 50000:50000 `
    -v jenkins_home:/var/jenkins_home `
    -v /var/run/docker.sock:/var/run/docker.sock `
    jenkins-ci:latest

Write-Host ""
Write-Host "Jenkins is starting..."
Write-Host "Open http://localhost:8081 in your browser (give it ~30 seconds on first launch)."
Write-Host ""
Write-Host "Initial admin password:"
Start-Sleep -Seconds 5
docker exec jenkins cat /var/jenkins_home/secrets/initialAdminPassword
