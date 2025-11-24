#!/bin/bash

# Docker Automation Script - Build, Run, Stop, and Remove containers
# Usage: ./docker_automation.sh [build|run|stop|remove|restart|status|logs]


DOCKER_IMAGE="myapp:latest"
DOCKER_CONTAINER="myapp-container"
DOCKERFILE_PATH="./Dockerfile"
PORT="8080:8080"

# Function to build Docker image
build_image() {
    echo "Building Docker image: $DOCKER_IMAGE..."
    
    if [ ! -f "$DOCKERFILE_PATH" ]; then
        echo "ERROR: Dockerfile not found at $DOCKERFILE_PATH"
        return 1
    fi
    
    docker build -t "$DOCKER_IMAGE" -f "$DOCKERFILE_PATH" .
    
    if [ $? -eq 0 ]; then
        echo "Docker image built successfully!"
        return 0
    else
        echo "ERROR: Failed to build Docker image"
        return 1
    fi
}

# Function to run Docker container
run_container() {
    echo "Running Docker container: $DOCKER_CONTAINER..."
    
    # Check if container already exists
    if docker ps -a --format '{{.Names}}' | grep -q "^${DOCKER_CONTAINER}$"; then
        echo "Container $DOCKER_CONTAINER already exists. Starting it..."
        docker start "$DOCKER_CONTAINER"
    else
        # Run new container
        docker run -d --name "$DOCKER_CONTAINER" -p "$PORT" "$DOCKER_IMAGE"
    fi
    
    if [ $? -eq 0 ]; then
        echo "Container $DOCKER_CONTAINER is running!"
        docker ps --filter "name=$DOCKER_CONTAINER"
        return 0
    else
        echo "ERROR: Failed to run container"
        return 1
    fi
}

# Function to stop Docker container
stop_container() {
    echo "Stopping Docker container: $DOCKER_CONTAINER..."
    
    if ! docker ps --format '{{.Names}}' | grep -q "^${DOCKER_CONTAINER}$"; then
        echo "Container $DOCKER_CONTAINER is not running"
        return 1
    fi
    
    docker stop "$DOCKER_CONTAINER"
    
    if [ $? -eq 0 ]; then
        echo "Container $DOCKER_CONTAINER stopped successfully!"
        return 0
    else
        echo "ERROR: Failed to stop container"
        return 1
    fi
}

# Function to remove Docker container
remove_container() {
    echo "Removing Docker container: $DOCKER_CONTAINER..."
    
    # Stop container if running
    if docker ps --format '{{.Names}}' | grep -q "^${DOCKER_CONTAINER}$"; then
        echo "Stopping container first..."
        docker stop "$DOCKER_CONTAINER"
    fi
    
    # Remove container
    docker rm "$DOCKER_CONTAINER"
    
    if [ $? -eq 0 ]; then
        echo "Container $DOCKER_CONTAINER removed successfully!"
        return 0
    else
        echo "ERROR: Failed to remove container"
        return 1
    fi
}

# Function to restart Docker container
restart_container() {
    echo "Restarting Docker container: $DOCKER_CONTAINER..."
    
    stop_container
    sleep 2
    run_container
    
    echo "Container $DOCKER_CONTAINER restarted successfully!"
    return 0
}

# Function to check container status
status_container() {
    echo "Checking status of Docker container: $DOCKER_CONTAINER..."
    
    if docker ps --format '{{.Names}}' | grep -q "^${DOCKER_CONTAINER}$"; then
        echo "$DOCKER_CONTAINER is RUNNING"
        docker ps --filter "name=$DOCKER_CONTAINER"
        return 0
    elif docker ps -a --format '{{.Names}}' | grep -q "^${DOCKER_CONTAINER}$"; then
        echo "$DOCKER_CONTAINER is STOPPED"
        docker ps -a --filter "name=$DOCKER_CONTAINER"
        return 1
    else
        echo "$DOCKER_CONTAINER does not exist"
        return 1
    fi
}

# Function to view container logs
view_logs() {
    echo "Viewing logs for Docker container: $DOCKER_CONTAINER..."
    
    if ! docker ps -a --format '{{.Names}}' | grep -q "^${DOCKER_CONTAINER}$"; then
        echo "Container $DOCKER_CONTAINER does not exist"
        return 1
    fi
    
    docker logs -f "$DOCKER_CONTAINER"
    return 0
}

# Function to clean up images and containers
cleanup() {
    echo "Cleaning up Docker images and stopped containers..."
    
    # Remove stopped containers
    docker container prune -f
    
    # Remove dangling images
    docker image prune -f
    
    echo "Cleanup completed!"
    return 0
}

# Main script logic
case "$1" in
    build)
        build_image
        ;;
    run)
        run_container
        ;;
    stop)
        stop_container
        ;;
    remove)
        remove_container
        ;;
    restart)
        restart_container
        ;;
    status)
        status_container
        ;;
    logs)
        view_logs
        ;;
    cleanup)
        cleanup
        ;;
    *)
        echo "Docker Automation Script"
        echo "Usage: $0 {build|run|stop|remove|restart|status|logs|cleanup}"
        echo ""
        echo "Commands:"
        echo "  build      - Build Docker image from Dockerfile"
        echo "  run        - Run Docker container"
        echo "  stop       - Stop Docker container"
        echo "  remove     - Remove Docker container"
        echo "  restart    - Restart Docker container"
        echo "  status     - Check container status"
        echo "  logs       - View container logs"
        echo "  cleanup    - Clean up images and stopped containers"
        echo ""
        echo "Examples:"
        echo "  $0 build"
        echo "  $0 run"
        echo "  $0 restart"
        exit 1
        ;;
esac

exit $?
