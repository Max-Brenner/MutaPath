#!/usr/bin/env python3
"""Generate Markdown and HTML reports from AI reasoning output."""

import argparse

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--input', required=True)
    parser.add_argument('--out', required=True)
    args = parser.parse_args()

    # TODO: implement Markdown + HTML report generation
    raise NotImplementedError

if __name__ == '__main__':
    main()
