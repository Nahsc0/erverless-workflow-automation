def lambda_handler(event, context):
    # TODO: Write your code here
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
