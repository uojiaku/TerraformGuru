# import json

# def lambda_handler(event, context):
#     return {
#         'statusCode': 200,
#         'body': json.dumps('Hello from Lambda!')
#     }


from xml.dom.minidom import Attr
import boto3
import os.path
import os

# to query DynamoDB pass argument to the scan() method from boto3 package

def get_products(region: str) -> list:

    table = dynamodb.Table('products')
    dynamodb = boto3.resource('dynamodb')
    data = response['Items']
    response = table.scan(FilterExpression=Attr('region'))

    while 'LastEvaluatedKey' in response:
        response = table.scan(ExclusiveStartKey=response['LastEvaluatedKey'])
        data.extend(response['Items'])
    if not isinstance(get_products, str):
        return "400 BAD REQUEST"
    else:    
        return list        

def handler(event: list, context):
    # Example usage of 'generate_pdf' function:
    #
    # products = ['t-shirt', 'hoodie']
    # pdf = generate_pdf(products)

    return{
        "statusCode": 200,
        'body': ('OK!')
    }