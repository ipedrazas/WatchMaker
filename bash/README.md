# Watching with `curl`

The kubernetes HTTP API uses different ways to authorise requests.

First we need to get a valid a token, if you don't have a ServiceAccount, you will have to fetch a token from the master:

    export TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
    export API_SERVER=https://$KUBERNETES_SERVICE_HOST

    curl -k -X GET -H "Authorization: Bearer $TOKEN"   $API_SERVER/api/v1/pods | jq '.items[].metadata.name'

This command should return a list of pod names.
