#!/usr/bin/env python3
"""Annotate variants with coding/noncoding consequences and protein effects."""

import argparse

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--vcf', required=True)
    parser.add_argument('--out', required=True)
    args = parser.parse_args()

    # TODO: implement consequence annotation logic
    raise NotImplementedError

if __name__ == '__main__':
    main()
