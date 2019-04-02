#!/usr/bin/env python

import argparse
import json


def main(template_file: str, cloudfront_main_id: str, cloudfront_redirect_id: str):
    with open(template_file, 'r') as f:
        template = json.load(f)

    for widget in template['widgets']:
        for metric in widget['properties']['metrics']:
            if metric[4] != 'DistributionId':
                continue
            if metric[5] not in ('MAIN_ID', 'REDIRECT_ID'):
                raise Exception(f'Invalid template format: {metric[5]}')
            if metric[5] == 'MAIN_ID':
                metric[5] = cloudfront_main_id
            elif metric[5] == 'REDIRECT_ID':
                metric[5] = cloudfront_redirect_id

    return json.dumps(template, indent=4)

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("template_file", metavar='FILE', help='JSON template file', type=str)
    parser.add_argument("cloudfront_main_id", metavar='ID', help='CloudFront main distribution ID', type=str)
    parser.add_argument("cloudfront_redirect_id", metavar='ID', help='CloudFront redirect distribution ID', type=str)
    
    args = parser.parse_args()

    output = main(args.template_file, args.cloudfront_main_id, args.cloudfront_redirect_id)

    print(output)
