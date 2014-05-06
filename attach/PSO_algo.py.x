##-*- coding: UTF-8 -*-
#from random import uniform
#from copy import deepcopy

class PSO:

	'''
	particle_size	:	空间粒子维度
	particle_scope	:	不同维度的约束
	C1,C2			:	学习因子
	w				:	惯性权值
	max_w			:	惯性权值上界
	min_w			:	惯性权值下界
	max_iter		:	最大迭代次数
	func			:	目标函数
	extra_args		:	其他因子
	'''
	def __init__(self, pop_size, particle_size, particle_scope, C1, C2,\
					 w, max_w, min_w, max_iter, func, extra_args=None):
		self.func = func
		self.extra_args	= extra_args
		self.pop = []
		self.r = 0.729
		self.particle_size = particle_size
		self.min_range = particle_scope[::2]
		self.max_range = particle_scope[1::2]
		for i in xrange(pop_size):
			self.pop.append(self.initParticle())
		self.evaluate()
		self.gbest = deepcopy(self.pop[0])
		self.pbest = deepcopy(self.pop)
		self.C1 = C1
		self.C2 = C2
		self.w = w
		self.max_w = max_w
		self.min_w = min_w
		self.max_iter = max_iter
		self.cur_iter = 0

	def initParticle(self):
		particle = []
		position = []
		for j in xrange(self.particle_size):
			position.append(uniform(self.min_range[j], self.max_range[j]))
		particle.append(position)
		velocity = []
		for j in xrange(self.particle_size):
			velocity.append(uniform(-1, 1))
		particle.append(velocity)
		particle.append(0)
		return particle

	def update_velocity(self):
		w = self.max_w - self.cur_iter * ((self.max_w - self.min_w) / self.max_iter)
		i = 0
		for p in self.pop:
			for j in xrange(self.particle_size):
				p[1][j] = w * p[1][j] + uniform(0, self.C1) * (self.pbest[i][0][j] \
				- p[0][j]) + uniform(0, self.C2) * (self.gbest[0][j] - p[0][j])
			i += 1

	def evaluate(self):
		for p in self.pop:
			p[2] = self.func(p[0], self.extra_args)

	def move(self):
		i = 0
		for p in self.pop:
			for j in xrange(self.particle_size):
				p[0][j] += self.r * p[1][j]
				if p[0][j] > self.max_range[j] or p[0][j] < self.min_range[j]:
					self.pop[i] = self.initParticle()
					break
			i += 1
	
	def run(self, update_funcs=None):
		for i in xrange(self.max_iter):
			print "current iter = %d" % self.cur_iter
			self.update_velocity()
			self.move()
			self.evaluate()
			cpbest = deepcopy(self.pbest[0])
			for k in xrange(len(self.pop)):
				if self.pop[k][2] < self.pbest[k][2]:
					self.pbest[k] = deepcopy(self.pop[k])
				if self.pbest[k][2] < cpbest[2]:
					cpbest = self.pbest[k]
			if cpbest[2] < self.gbest[2]:
				self.gbest = cpbest
			print self.gbest[0][0]
			self.cur_iter += 1
	
	def __str__(self):
		ret = ""
		for i in self.pop:
			ret += str(i) + "\n"
		return ret
