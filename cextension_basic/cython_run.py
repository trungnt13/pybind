from cppmult import cppmult
from argparse import ArgumentParser


if __name__ == "__main__":
    # Sample data for our call
    parser = ArgumentParser()
    parser.add_argument("x", type=int)
    parser.add_argument("y", type=float)
    args = parser.parse_args()
    print(args)

    answer = cppmult(args.x, args.y)
    print(f"    In Python: int: {args.x} float {args.y:.1f} return val {answer:.1f}")
