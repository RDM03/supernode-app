if [ "$AGENT_JOBSTATUS" == "Succeeded" ]; then
    SSH_SERVER={SSH_SERVER}
    SSH_USER={SSH_USER}
    SSH_KEY={SSH_KEY}

    # Example: Upload sam/v1.2.1/appcenter branch app binary to China server using the ssh key
    if [ "$APPCENTER_BRANCH" == "sam/v1.2.1/appcenter" ];
     then
        rsync -e ssh \
        --progress \
        android/app/build/outputs/apk/app-release.apk \
        SSH_USER@SSH_SERVER:reverse_proxy/apk
    else
        echo "Current branch is $APPCENTER_BRANCH"
    fi
fi