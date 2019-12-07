#include <iostream>
#include <string>
#include <vector>

#include <llvm/Support/Casting.h>

struct Node {
	// Discriminator for LLVM-style RTTI
	enum NodeKind {
		NK_NInteger,
		NK_NIdent
	};
private:
	const NodeKind kind;
public:
	NodeKind get_kind() const {
		return kind;
	}

	Node(NodeKind kind) : kind(kind) {}
	virtual ~Node() {}

	virtual std::string whoami() const {
		return "Base Node";
	}
};

struct NInteger : public Node {
	NInteger() : Node(NK_NInteger) {}
	virtual std::string whoami() const {
		return "Integer Node";
	}
	static bool classof(const Node *node) {
		return node->get_kind() == NK_NInteger;
	}
};

struct NIdent : public Node {
	NIdent() : Node(NK_NIdent) {}
	virtual std::string whoami() const {
		return "Ident Node";
	}
	static bool classof(const Node *node) {
		return node->get_kind() == NK_NIdent;
	}
};

typedef std::vector<Node *> NodePtrVector;

int main(int argc, char *argv[])
{
	// Single stack-allocated variable (doesn't work, invokes static dispatch)
	Node n_auto = NInteger(); // Normally, you wouldn't write this,
	                          // for demonstration purposes only
	std::cout << n_auto.whoami() << std::endl;

	// Single dynamically-allocated variable (works, invokes dynamic dispatch)
	Node *n_dyn = new NInteger;
	std::cout << n_dyn->whoami() << std::endl;
	delete n_dyn;

	// Collection (requires homogenous type)
	NodePtrVector nodes;
	nodes.push_back(new NInteger);
	nodes.push_back(new NIdent);

	// Successful downcast
	if (NInteger *n_cast = llvm::dyn_cast<NInteger>(nodes[0])) {
		std::cout << "Successful cast to " << n_cast->whoami() << std::endl;
	} else {
		std::cout << "Unsuccessful cast to Integer Node" << std::endl;
	}

	// Unsuccessful downcast
	if (NIdent *n_cast = llvm::dyn_cast<NIdent>(nodes[0])) {
		std::cout << "Successful cast to " << n_cast->whoami() << std::endl;
	} else {
		std::cout << "Unsuccessful cast to Ident Node" << std::endl;
	}

	// Iteration
	for (NodePtrVector::const_iterator it = nodes.begin(); it != nodes.end(); ++it) {
		std::cout << (*it)->whoami() << std::endl;
	}

	// Cleanup
	for (NodePtrVector::iterator it = nodes.begin(); it != nodes.end(); ++it) {
		delete *it;
	}

	return 0;
}
