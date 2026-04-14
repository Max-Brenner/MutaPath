#!/usr/bin/env python3
"""Send evidence JSON to LLM API and return mechanistic hypotheses."""

import argparse

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--input', required=True)
    parser.add_argument('--out', required=True)
    args = parser.parse_args()

    # TODO: implement LLM API call with evidence schema as input
    raise NotImplementedError

if __name__ == '__main__':
    main()
