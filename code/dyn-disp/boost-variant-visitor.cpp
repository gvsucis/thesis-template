#include <iostream>
#include <string>
#include <vector>

#include <boost/variant.hpp>

struct Node {
	virtual ~Node() {}
};

struct NInteger : public Node {};

struct NIdent : public Node {};

struct WhoamiVisitor : public boost::static_visitor<std::string> {
	std::string operator()(const Node&) const {
		return "Base Node";
	}
	std::string operator()(const NInteger&) const {
		return "Integer Node";
	}
	std::string operator()(const NIdent&) const {
		return "Ident Node";
	}
};

typedef boost::variant<Node, NInteger, NIdent> NodeVariant;
typedef std::vector<NodeVariant> NodeVariantVector;

int main(int argc, char *argv[])
{
	WhoamiVisitor whoami_visitor;

	// Single stack-allocated variable (doesn't work, invokes static dispatch)
	Node n_auto = NInteger(); // Normally, you wouldn't write this,
	                          // for demonstration purposes only
	std::cout << whoami_visitor(n_auto) << std::endl;

	// Single stack-allocated variant (works, uses visitor pattern)
	NodeVariant n_auto_variant = NInteger();
	std::cout << boost::apply_visitor(whoami_visitor, n_auto_variant) << std::endl;

	// Collection (requires homogenous type)
	NodeVariantVector nodes;
	nodes.push_back(NInteger());
	nodes.push_back(NIdent());

	// Successful downcast
	if (NInteger *n_cast = boost::get<NInteger>(&nodes[0])) {
		std::cout << "Successful cast to " << whoami_visitor(*n_cast) << std::endl;
	} else {
		std::cout << "Unsuccessful cast to Integer Node" << std::endl;
	}

	// Unsuccessful downcast
	if (NIdent *n_cast = boost::get<NIdent>(&nodes[0])) {
		std::cout << "Successful cast to " << whoami_visitor(*n_cast) << std::endl;
	} else {
		std::cout << "Unsuccessful cast to Ident Node" << std::endl;
	}

	// Iteration
	for (NodeVariantVector::const_iterator it = nodes.begin(); it != nodes.end(); ++it) {
		std::cout << boost::apply_visitor(whoami_visitor, *it) << std::endl;
	}

	// No cleanup necessary

	return 0;
}
